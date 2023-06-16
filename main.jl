using Makie

struct Config
    epochs::Int
    n_individuals::Int
end

config = Config(100, 30)
random_pos(n_elements::Int, scalar::Int)::Array{Float32, 1} = (rand(Float32, n_elements) * 2 .- 1) * scalar
Boid = Array{Float32, 1}
random_boid() = Boid(random_pos(2, 10))

# spawn swarm of boids
swarm = rand(Float32, (2, config.n_individuals))
# create the animation
points = Observable(swarm)
fig, ax = scatter(points)
limits!(ax, -100, 100, -1-0, 100)
frames = 1:config.epochs

mov = Float32.([1.3, 0.4])
# start recording
record(fig, "boids.mp4", frames; framerate = 30) do frame
  for epoch in 1:config.epochs
      for (index, boid) in enumerate(swarm)
          new_pos = boid.pos + mov
          # collision bounds checking
          for axis in 1:2
              if !(-100 < new_pos[axis] < 100)
                  new_pos[axis] *= -1
              end
          end
          swarm[index] = new_pos 
      end
  end
  points[] = swarm[]
end


# virer le discard, decoding et other, deprecated_..., monitoring parameters, class_loader, algorithm_identifier, supervised... => tests
