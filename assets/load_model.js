    let scene, camera, renderer;

    function init() {

    var el3 = document.querySelector('three-viewer');

    console.log('-----initing-----' + el3.Scene());
    return;
      scene = new THREE.Scene();
      camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
      renderer = new THREE.WebGLRenderer();
      renderer.setSize(window.innerWidth, window.innerHeight);
      document.body.appendChild(renderer.domElement);

      camera.position.z = 5;
      animate();
      console.log('-----initing end-----');
    }

    function loadModel(modelPath) {
      const objLoader = new THREE.OBJLoader();
      objLoader.load(modelPath, (object) => {
        scene.add(object);
      });
    }

    function animate() {
      requestAnimationFrame(animate);
      renderer.render(scene, camera);
    }