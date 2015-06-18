# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

project = Project.create name: 'Libro Aprendiendo Ruby on Rails 4', active: true

project.tasks.create name: 'Escribir capítulo', billeable: false
project.tasks.create name: 'Escribir ejemplo', billeable: false
project.tasks.create name: 'Liberar versión', billeable: false
