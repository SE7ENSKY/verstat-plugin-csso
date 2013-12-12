module.exports = (next) ->
	csso = require 'csso'
	@postprocessor 'csso',
		extname: '.css'
		priority: 1000
		postprocess: (file, donePostprocessor) =>
			return donePostprocessor() unless file.csso
			try
				if file.processor
					file.processed = csso.justDoIt file.processed
				else
					file.source = csso.justDoIt file.source
				@modified file
				donePostprocessor()
			catch err
				donePostprocessor err

	next()