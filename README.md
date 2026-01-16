<div align="center">
 <img width="250" height="200" alt="Immunition Banner" src="https://github.com/user-attachments/assets/b014a52d-f257-48c0-ac3a-ca5a14bcc32a" />
  />

  <h1>🦠 IMMUNITION 2.0</h1>
  
  <p>
    <strong>A 3D Educational FPS about Microbiology and Immune Defense.</strong>
  </p>

  <p>
    <a href="https://godotengine.org">
      <img src="https://img.shields.io/badge/Engine-Godot%204.3-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white" />
    </a>
    <a href="#">
      <img src="https://img.shields.io/badge/Language-GDScript-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white" />
    </a>
    <a href="https://veggi3.itch.io/immunition-final">
      <img src="https://img.shields.io/badge/Play%20on-Itch.io-FA5C5C?style=for-the-badge&logo=itch.io&logoColor=white" />
    </a>
  </p>
</div>

---

## 📖 About the Project

**Immunition** is a fast-paced First-Person Shooter (FPS) developed as a Capstone Project for the Digital Games Degree. The game simulates the human immune system, where the player controls a white blood cell defending the body against viral waves.

The goal was to combine **Arcade Mechanics** (inspired by *Doom* and *Quake*) with **Educational Content**, ensuring accurate biological metaphors while maintaining high-performance gameplay on WebGL.

---

## ⚙️ Engineering & Architecture

This project focuses on scalable systems and optimization for web-based deployment. Key technical achievements include:

### 🧠 Finite State Machine (AI)
Implemented a modular **Finite State Machine (FSM)** from scratch to handle Enemy AI behaviors. This allows for decoupled logic and easy expansion of new enemy types.
* **States:** `Idle`, `Patrol`, `Chase`, `Attack`, `Flee`.
* **Logic:** Enemies dynamically switch states based on player distance, line of sight (Raycasts), and health thresholds.


### 🎯 Physics: Continuous Collision Detection
Solved the "Tunneling Effect" (where fast bullets pass through thin walls) common in standard physics engines.
* **Solution:** Implemented custom **Raycasting** ahead of the projectile's trajectory frame-by-frame to detect hits before the physics step updates.

---

## 🕹️ Gameplay & Controls

| Action | Input |
| :--- | :--- |
| **Move** | `W`, `A`, `S`, `D` |
| **Shoot** | `Left Mouse Button` |
| **Jump** | `Space` |
| **Switch Weapon** | `1`, `2`, `3` or `Scroll` |

---

## 🛠️ Credits & Tools

* **Lead Programmer & Sound Designer:** Matheus Soares ([@MrVeGGi3](https://github.com/MrVeGGi3))
* **Level Designer & 3D Artist:** Lucas Camillo
* **Concept Art, UX/UI and 2D Arts:** Daniel Marto da Silva
* **Engine:** Godot 4.3
* **Audio:** Audacity & Musescore

---

<div align="center">
  <p><i>Developed with 💙 by VeGGi3</i></p>
</div>

