This project has a scene CompositionExample > Scenes > Test.scene which has two cubes on screen, CubeRed and a CubeBlue, but only applies bloom to the blue one. 

First, please notice that CubeBlue has a Blue Layer assigned to it.

The scene main camera, SeeAllCamera, has both the Amplify Bloom Effect component and a Render Color Mask component.

A second camera is nested on SeeAllCamera. But, as you can notice, it's disabled as it will only be used to generate a mask based on the specified Layer Mask property on the Render Color Mask component. 

This mask is then used on Amplify Bloom Effect to limit bloom generation to the specified area.