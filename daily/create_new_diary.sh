
filename="`date +%Y%m%d`"
dirname="`date +%Y`/diary`date +%Y%m`"
path="${dirname}/${filename}.md"
city="tokyo"

news_property=(
    "us general 100"
    "jp general 100"
    "jp business 100"
	"tw general 100"
    "cn general 100"
)


if [ ! -d "${dirname}" ]; then
	mkdir -p "${dirname}"
fi

if [ ! -f ${path} ]; then
	## add title
	echo "# ${filename}" >> ${path}

	# get weather from open weather map
	curl "api.openweathermap.org/data/2.5/weather?q=${city}&appid=$WEATHER_API_KEY&units=metric" > weather.json
	cat weather.json | jq '.["weather"][0]["main"]' | sed 's/[{} \"\"]//g' >> ${path} 
	cat weather.json | jq '.["name"]' | sed 's/[{} \"\"]//g' >> ${path}
	cat weather.json | jq '.["main"]' | sed 's/[{} \"\"]//g' >> ${path}
	rm weather.json
	
	cat template.md >> ${path}

	# add news
	for i in "${news_property[@]}"; do
		np=(${i[@]})

		echo "**${np[0]} ${np[1]}**" >> ${path}
		python ~/projects/multi-language-news-bot/client.py -l ${np[0]} -c ${np[1]} -p ${np[2]} >> ${path}
	done
	
fi

code ${path}

exit 0

