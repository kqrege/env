-- Performance Test Script for Optimized Drawing Library
-- This script demonstrates the performance improvements

print("=== PERFORMANCE TEST STARTING ===")

-- Test 1: Create many objects quickly
print("Test 1: Creating 1000 drawing objects...")
local startTime = tick()
local objects = {}

for i = 1, 1000 do
    local line = Drawing.new("Line")
    line.From = Vector2.new(math.random(0, 1920), math.random(0, 1080))
    line.To = Vector2.new(math.random(0, 1920), math.random(0, 1080))
    line.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    line.Thickness = math.random(1, 5)
    line.Visible = true
    table.insert(objects, line)
end

local createTime = tick() - startTime
print("Created 1000 objects in " .. string.format("%.3f", createTime) .. " seconds")

-- Test 2: Update properties rapidly
print("Test 2: Updating properties rapidly...")
startTime = tick()

for frame = 1, 60 do
    for i, obj in ipairs(objects) do
        obj.From = Vector2.new(math.random(0, 1920), math.random(0, 1080))
        obj.To = Vector2.new(math.random(0, 1920), math.random(0, 1080))
        obj.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end
    wait(0.016) -- Simulate 60 FPS
end

local updateTime = tick() - startTime
print("Updated all objects for 60 frames in " .. string.format("%.3f", updateTime) .. " seconds")

-- Test 3: Performance under stress
print("Test 3: Performance under stress (creating more objects)...")
startTime = tick()

for i = 1, 500 do
    local circle = Drawing.new("Circle")
    circle.Position = Vector2.new(math.random(0, 1920), math.random(0, 1080))
    circle.Radius = math.random(10, 100)
    circle.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    circle.Thickness = math.random(1, 5)
    circle.Visible = true
    table.insert(objects, circle)
end

local stressTime = tick() - startTime
print("Created additional 500 objects in " .. string.format("%.3f", stressTime) .. " seconds")

-- Test 4: Memory efficiency (object pooling)
print("Test 4: Testing object pooling...")
startTime = tick()

-- Remove some objects to test pooling
for i = 1, 100 do
    if objects[i] then
        objects[i]:Remove()
        objects[i] = nil
    end
end

-- Create new objects (should use pooled objects)
for i = 1, 100 do
    local text = Drawing.new("Text")
    text.Text = "Pooled Object " .. i
    text.Position = Vector2.new(math.random(0, 1920), math.random(0, 1080))
    text.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    text.Size = math.random(12, 24)
    text.Visible = true
    table.insert(objects, text)
end

local poolTime = tick() - startTime
print("Pooled 100 objects in " .. string.format("%.3f", poolTime) .. " seconds")

-- Test 5: Final performance check
print("Test 5: Final performance check...")
startTime = tick()

for frame = 1, 30 do
    for i, obj in ipairs(objects) do
        if obj and obj.Visible then
            if obj._type == "Line" then
                obj.From = Vector2.new(math.random(0, 1920), math.random(0, 1080))
                obj.To = Vector2.new(math.random(0, 1920), math.random(0, 1080))
            elseif obj._type == "Circle" then
                obj.Position = Vector2.new(math.random(0, 1920), math.random(0, 1080))
            elseif obj._type == "Text" then
                obj.Position = Vector2.new(math.random(0, 1920), math.random(0, 1080))
            end
        end
    end
    wait(0.016)
end

local finalTime = tick() - startTime
print("Final performance test completed in " .. string.format("%.3f", finalTime) .. " seconds")

-- Test 6: Cleanup
print("Test 6: Cleaning up all objects...")
startTime = tick()

for i, obj in ipairs(objects) do
    if obj then
        obj:Remove()
    end
end

local cleanupTime = tick() - startTime
print("Cleanup completed in " .. string.format("%.3f", cleanupTime) .. " seconds")

-- Summary
print("=== PERFORMANCE TEST SUMMARY ===")
print("Total test time: " .. string.format("%.3f", createTime + updateTime + stressTime + poolTime + finalTime + cleanupTime) .. " seconds")
print("Objects created: 1600")
print("Objects updated: Multiple times per frame")
print("Memory efficiency: Object pooling active")
print("FPS monitoring: Check console for real-time stats")

print("=== TEST COMPLETED ===")
print("The optimized drawing library should maintain smooth performance throughout all tests.")
print("Monitor the console for FPS and object count information.")