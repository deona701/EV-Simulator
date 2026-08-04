import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    Texture {
        id: _Blender_textures_cgbookcase_Brushed_iron_02_4K_Normal_png_texture
        objectName: "/Blender/textures/cgbookcase/Brushed_iron_02_4K_Normal.png"
        pivotU: 0.5
        pivotV: 0.5
        scaleU: 0.3333333432674408
        scaleV: 0.3333333432674408
        generateMipmaps: true
        mipFilter: Texture.Linear
        // Source texture path expected: maps/Brushed_iron_02_4K_Normal.png
        // Skipped property: source, reason: Failed to find texture at /Blender/textures/cgbookcase/Brushed_iron_02_4K_Normal.png
    }
    Texture {
        id: _Users_nithinlobo_Downloads_plate_png_texture
        objectName: "/Users/nithinlobo/Downloads/plate.png"
        generateMipmaps: true
        mipFilter: Texture.Linear
        // Source texture path expected: maps/plate.png
        // Skipped property: source, reason: Failed to find texture at /Users/nithinlobo/Downloads/plate.png
    }
    PrincipledMaterial {
        id: headights_emissions_material
        objectName: "headights.emissions"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: metal_dark_material
        objectName: "Metal-dark"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: metal_gray_warmer_material
        objectName: "Metal-gray-warmer"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: tyres_material
        objectName: "Tyres"
        baseColor: "#ff0f0f0f"
        roughness: 0.30000001192092896
    }
    PrincipledMaterial {
        id: metal_brake_discs_material
        objectName: "Metal-brake_discs"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: tesla_red_material
        objectName: "Tesla.red"
        baseColor: "#ff515151"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: headights_emissions_led_material
        objectName: "headights.emissions.led"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: headlight_reflective_material
        objectName: "headlight_reflective"
        baseColor: "#ff3d3d3d"
    }
    PrincipledMaterial {
        id: material_material
        objectName: "Material"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: mirror_material
        objectName: "mirror"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: backights_grey_material
        objectName: "backights.grey"
        baseColor: "#ff515151"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: backights_red_material
        objectName: "backights.red"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: backights_grey_001_material
        objectName: "backights.grey.001"
        baseColor: "#ffc9c9c9"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: backights_off_material
        objectName: "backights.off"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: tesla_material
        objectName: "Tesla"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: indicator_material
        objectName: "indicator"
        baseColor: "#ffc93c12"
    }
    PrincipledMaterial {
        id: metal_gray_material
        objectName: "Metal-gray"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: glass_dark_material
        objectName: "glass.dark"
        baseColor: "#ff030303"
        roughness: 0.11999998241662979
    }
    PrincipledMaterial {
        id: plastic_black_material
        objectName: "plastic.black"
        baseColor: "#ff030303"
        roughness: 0.18000000715255737
    }
    PrincipledMaterial {
        id: glass_material
        objectName: "glass"
        baseColor: "#ff0a0a0a"
    }
    PrincipledMaterial {
        id: white_material
        objectName: "white"
        baseColor: "#ffcccccc"
        roughness: 0.2160000056028366
    }
    PrincipledMaterial {
        id: glass_front_material
        objectName: "glass.front"
        baseColor: "#ffcccccc"
        roughness: 0.4000000059604645
    }
    PrincipledMaterial {
        id: grid_material
        objectName: "grid"
        baseColor: "#ffcccccc"
        roughness: 0.5
    }
    PrincipledMaterial {
        id: frontPlaqueImage_material
        objectName: "FrontPlaqueImage"
        baseColor: "#ffcccccc"
        baseColorMap: _Users_nithinlobo_Downloads_plate_png_texture
        roughness: 0.5
    }
    PrincipledMaterial {
        id: floor_material
        objectName: "floor"
        baseColor: "#ff414141"
        roughness: 0.18000000715255737
        normalMap: _Blender_textures_cgbookcase_Brushed_iron_02_4K_Normal_png_texture
    }

    // Nodes:
    Node {
        id: rootNode
        objectName: "RootNode"
        Model {
            id: tesla
            objectName: "tesla"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/plane_002_mesh.mesh"
            materials: [
                tesla_material
            ]
        }
        Model {
            id: tesla_001
            objectName: "tesla.001"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/plane_003_mesh.mesh"
            materials: [
                tesla_material
            ]
        }
        Model {
            id: tesla_002
            objectName: "tesla.002"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_002_mesh.mesh"
            materials: [
                tesla_material,
                indicator_material
            ]
        }
        Model {
            id: tesla_003
            objectName: "tesla.003"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_003_mesh.mesh"
            materials: [
                tesla_material,
                metal_gray_material,
                glass_dark_material,
                plastic_black_material,
                glass_material
            ]
        }
        Model {
            id: tesla_004
            objectName: "tesla.004"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_004_mesh.mesh"
            materials: [
                tesla_material,
                metal_gray_material,
                glass_material
            ]
        }
        Model {
            id: tesla_005
            objectName: "tesla.005"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_005_mesh.mesh"
            materials: [
                tesla_material,
                metal_gray_material,
                glass_material
            ]
        }
        Model {
            id: tesla_006
            objectName: "tesla.006"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/plane_009_mesh.mesh"
            materials: [
                tesla_material
            ]
        }
        Model {
            id: tesla_007
            objectName: "tesla.007"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_007_mesh.mesh"
            materials: [
                tesla_material,
                glass_material,
                glass_dark_material,
                metal_gray_material
            ]
        }
        Model {
            id: tesla_008
            objectName: "tesla.008"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/plane_011_mesh.mesh"
            materials: [
                tesla_material
            ]
        }
        Model {
            id: tesla_010
            objectName: "tesla.010"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_010_mesh.mesh"
            materials: [
                tesla_material,
                metal_gray_material
            ]
        }
        Model {
            id: tesla_009
            objectName: "tesla.009"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_009_mesh.mesh"
            materials: [
                metal_gray_material,
                glass_front_material
            ]
        }
        Model {
            id: tyres
            objectName: "tyres"
            position: Qt.vector3d(-7.81737, 0, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(100, 100, 100)
            source: "meshes/tyres_mesh.mesh"
            materials: [
                metal_gray_material,
                metal_dark_material,
                metal_gray_warmer_material,
                tyres_material,
                metal_brake_discs_material,
                tesla_red_material
            ]
        }
        Model {
            id: tesla_011
            objectName: "tesla.011"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_011_mesh.mesh"
            materials: [
                glass_front_material,
                headights_emissions_led_material,
                headlight_reflective_material,
                headights_emissions_material,
                plastic_black_material,
                metal_gray_material,
                tesla_material,
                mirror_material
            ]
        }
        Model {
            id: tesla_012
            objectName: "tesla.012"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_012_mesh.mesh"
            materials: [
                glass_front_material,
                backights_grey_material,
                backights_red_material,
                backights_grey_001_material
            ]
        }
        Model {
            id: tesla_013
            objectName: "tesla.013"
            position: Qt.vector3d(0, 2.5996, 0)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(248.8, 100, 100)
            source: "meshes/tesla_013_mesh.mesh"
            materials: [
                plastic_black_material,
                metal_gray_material,
                backights_off_material
            ]
        }
        PerspectiveCamera {
            id: camera_camera
            objectName: "Camera"
            position: Qt.vector3d(-605.463, 135.147, 547.203)
            rotation: Qt.quaternion(0.382348, 0.0160251, 0.923069, -0.0386881)
            scale: Qt.vector3d(100, 100, 100)
            clipFar: 1e+05
            fieldOfView: 19.79887580871582
            fieldOfViewOrientation: PerspectiveCamera.Horizontal
        }
        PerspectiveCamera {
            id: camera_001_camera
            objectName: "Camera.001"
            position: Qt.vector3d(651.338, 134.064, 145.76)
            rotation: Qt.quaternion(0.579464, 0.0263184, -0.813734, 0.036955)
            scale: Qt.vector3d(100, 100, 100)
            clipFar: 1e+05
            fieldOfView: 19.79887580871582
            fieldOfViewOrientation: PerspectiveCamera.Horizontal
        }
        PerspectiveCamera {
            id: camera_003_camera
            objectName: "Camera.003"
            position: Qt.vector3d(-912, 753, 0)
            rotation: Qt.quaternion(0.666548, 0.236037, 0.666548, -0.236037)
            scale: Qt.vector3d(100, 100, 100)
            clipFar: 1e+05
            fieldOfView: 19.79887580871582
            fieldOfViewOrientation: PerspectiveCamera.Horizontal
        }
    }

    // Animations:
}
