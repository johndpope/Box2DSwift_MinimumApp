import UIKit
import Box2D

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Define the gravity vector.
    let gravity = b2Vec2(0.0, -10.0)
    
    // Construct a world object, which will hold and simulate the rigid bodies.
    let world = b2World(gravity: gravity)
    
    // Define the ground body.
    let groundBodyDef = b2BodyDef()
    groundBodyDef.position.set(0.0, -10.0)
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world.
    let groundBody = world.createBody(groundBodyDef)
    
    // Define the ground box shape.
    let groundBox = b2PolygonShape()
    
    // The extents are the half-widths of the box.
    groundBox.setAsBox(halfWidth: 50.0, halfHeight: 10.0)
    
    // Add the ground fixture to the ground body.
    groundBody.createFixture(shape: groundBox, density: 0.0)
    
    // Define the dynamic body. We set its position and call the body factory.
    let bodyDef = b2BodyDef()
    bodyDef.type = b2BodyType.dynamicBody
    bodyDef.position.set(0.0, 4.0)
    let body = world.createBody(bodyDef)
    
    // Define another box shape for our dynamic body.
    let dynamicBox = b2PolygonShape()
    dynamicBox.setAsBox(halfWidth: 1.0, halfHeight: 1.0)
    
    // Define the dynamic body fixture.
    let fixtureDef = b2FixtureDef()
    fixtureDef.shape = dynamicBox
    
    // Set the box density to be non-zero, so it will be dynamic.
    fixtureDef.density = 1.0
    
    // Override the default friction.
    fixtureDef.friction = 0.3
    
    // Add the shape to the body.
    body.createFixture(fixtureDef)
    
    // Prepare for simulation. Typically we use a time step of 1/60 of a
    // second (60Hz) and 10 iterations. This provides a high quality simulation
    // in most game scenarios.
    let timeStep: b2Float = 1.0 / 60.0
    let velocityIterations = 6
    let positionIterations = 2
    
    // This is our little game loop.
    for i in 0 ..< 60 {
      if i == 45 {
        print("stop")
      }
      // Instruct the world to perform a single step of simulation.
      // It is generally best to keep the time step and iterations fixed.
      world.step(timeStep: timeStep, velocityIterations: velocityIterations, positionIterations: positionIterations)
      //world.dump()
      
      // Now print the position and angle of the body.
      //body.dump()
      let position = body.position
      let angle = body.angle
      
      //world.dump()
      print("\(i): \(position.x) \(position.y) \(angle)")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

