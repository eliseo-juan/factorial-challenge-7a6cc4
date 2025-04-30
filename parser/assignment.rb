# frozen_string_literal: true

require "./services/reader"
require "./services/ox_reader"
require "./services/sax_parser"
require "./services/batcher"
require "./services/old_batcher"
require "./services/external_service"
require "get_process_mem"

PATH = "resources/feed-huge.xml"

def run(name)
  puts "Running in #{name} mode"
  t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  yield
  t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  mem = GetProcessMem.new

  puts "Time: #{t2 - t1}s"
  puts "Mem: #{mem.mb} mb"
  puts "-" * 20
end

def run_original
  external_service = Services::ExternalService.new

  items = Services::Reader.new(PATH).items
  batches = Services::OldBatcher.new(items).process

  batches.each do |batch|
    external_service.call(batch.to_json)
  end
end

def run_nokogiri
  external_service = Services::ExternalService.new
  items = Services::Reader.new(PATH).items

  Services::Batcher.new(items).with_service do |batch|
    external_service.call(batch.to_json)
  end
end

def run_ox
  external_service = Services::ExternalService.new
  items = Services::OxReader.new(PATH).items
  Services::Batcher.new(items).with_service do |batch|
    external_service.call(batch.to_json)
  end
end

def run_sax
  external_service = Services::ExternalService.new
  Services::SaxParser.new(PATH, external_service).execute
end

mode = ENV["MODE"]
unless ["original", "nokogiri", "ox", "sax"].include?(mode)
  puts "Mode not supported"
  return
end

run(mode) do
  eval "run_#{mode}"
end
