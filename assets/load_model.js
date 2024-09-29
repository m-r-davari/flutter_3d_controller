
import * as THREE from './three_viewer.js';
import { OBJLoader } from './obj_loader.js';


let scene, camera, renderer;

function init() {
console.log('-----------------initing---------------');///
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.getElementById('flutter_container').appendChild(renderer.domElement);

    // Add lights
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
    scene.add(ambientLight);
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    scene.add(directionalLight);

    camera.position.z = 5;
    console.log('-----------------initing end---------------');
}

export function loadModel(modelUrl) {
    const loader = new OBJLoader();
    loader.load(
        modelUrl,
        (object) => {
            scene.add(object);
            object.position.set(0, 0, 0); // Adjust as needed
            animate(); // Start the animation loop once the model is loaded
        },
        (xhr) => {
            console.log((xhr.loaded / xhr.total * 100) + '% loaded');
        },
        (error) => {
            console.error('An error occurred loading the model:', error);
        }
    );
}

function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}

// Initialize the scene
init();