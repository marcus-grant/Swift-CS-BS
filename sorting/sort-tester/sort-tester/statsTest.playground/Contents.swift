//: Playground - noun: a place where people can play

import Cocoa

let testStats = [1.0, 2.0, 3.0, 4.0, 5.0]

func stats(data: [Double])
  -> (min: Double, max: Double, mean: Double, stdDev: Double)
{
  let samples = Double(data.count)
  let min = data.minElement()!
  let max = data.maxElement()!
  let mean = data.reduce(0){$0 + $1} / samples
  let stdDev = sqrt(data.map{ pow($0 - mean, 2) }.reduce(0, combine: { $0 + $1 }) / samples)
  return (min, mean, max, stdDev)
}

let (min, mean, max, stdDev) = stats(testStats)

let labels = ["min: ", "max: ", "mean: ", "stdDev: "]
let values = ["\(min)", "\(max)","\(mean)", "\(stdDev)"]
var outputString = String()
for index in 0..<labels.count {
  outputString += labels[index]
  outputString += values[index]
  outputString += "\n"
}

print(outputString)
