local leds = {}

for i = 0, 100 do
    local led = ac.findMeshes("LED_" .. i)
    if led.empty(led) then
        break
    end
    table.insert(leds, led)
end

braked = false
car = ac.getCar(0)
color = vec3(2, 0, 202)

function script.update()
    local brake = car.brake
    if brake > 0 then
        braked = true
        for i = 1, #leds do
            if (i <= math.ceil(brake * #leds)) then
                leds[i].setMaterialProperty(leds[i], "ksEmissive", vec3(0, 0, 0))
                leds[i].setMaterialProperty(leds[i], "ksEmissive", color)
            else
                leds[i].setMaterialProperty(leds[i], "ksEmissive", vec3(0, 0, 0))
            end
        end
    elseif braked then
        braked = false
        for i = 1, #leds do
            leds[i].setMaterialProperty(leds[i], "ksEmissive", vec3(0, 0, 0))
        end
    end
end
