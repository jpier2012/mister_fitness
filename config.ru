require './config/environment'

use Rack::MethodOverride
use SessionsController
use UsersController
use WorkoutsController
use ExercisesController
run ApplicationController
