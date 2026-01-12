[![Watch the video](https://img.youtube.com/vi/MBSwIDd1u10/maxresdefault.jpg)](https://youtu.be/MBSwIDd1u10)

### [Watch this video on YouTube](https://youtu.be/MBSwIDd1u10)

# 🚗 IL-Cruise – FiveM Speed Limiter

**IL-cruise** is a lightweight FiveM script that allows players to set a maximum top speed their vehicle cannot exceed. Perfect for avoiding traffic cameras, speeding fines, and unwanted police attention.

Built for **QBCore**.

---

## ✨ Features

- Set a hard speed cap for your vehicle  
- Works in **MPH or KM/H**  
- Customizable command  
- Min/Max speed limits  
- Automatically disables if you exit the vehicle  
- Optional notifications  

---

## 📦 Installation

### 1️⃣ Add Resource

Place the folder into your server’s `resources` directory:


---

### 2️⃣ Edit Config

Open `config.lua` and adjust to your liking:

```lua
Config.SpeedLimiter = {
    enabled = true,         -- Enable/disable speed limiter
    command = 'setspeed',   -- Command used in-game
    useMPH = true,          -- true = MPH, false = KM/H
    minSpeed = 0,           -- Minimum allowed speed (0 disables limiter)
    maxSpeed = 200,         -- Maximum allowed speed
    showNotifications = true
}
```

### 3️⃣ Ensure Resource

Add the resource to your server.cfg:

ensure IL-cruise


### ⚙ Notes

You must be the driver of the vehicle.

The limiter automatically turns off if you exit the vehicle.

Speed is enforced by SetVehicleMaxSpeed for consistent behavior.
