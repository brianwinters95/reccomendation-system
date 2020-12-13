import csv

#Opening the csv file and giving a name to the csv file + creating a list of it
file = csv.reader(open('/home/pi/VE/userReviews.csv'), delimiter = ';')
data = list(file)
#print(data)

subset = list()

#Give a name to the variables 
for film in data: 
	if film[0] == 'interstellar':
		subset.append(film)
		#print(subset)
		
recommendations = list()

#calculate the relative and absolute increase 
for film in subset:
    for y in data:
        if film[2] == y[2] and int(film[1]) > 7 and int(y[1]) >= int(film[1]):
            abs_inc = int(y[1]) - int(film[1])
            rel_inc = (int(y[1]) - int(film[1])) / int(film[1])
            recommendation = (y[0],y[1],y[2],y[3],y[4],y[5],y[6],y[7],y[8],y[9],abs_inc, rel_inc)
            recommendations.append(recommendation)
#print(recommendations)

#selecting variables 
sortedrecommendations = sorted(recommendations, key=lambda tup: (tup[11]), reverse=True)
print(sortedrecommendations)

#saving the data
csvwriter = csv.writer(open('resit.csv', 'w'))

#insert headers in new recommendations csv file
header = ['movieName', 'Metascore_w', 'Author', 'AuthorHref', 'Date', 'Summary', 'InteractionsYesCount', 'InteractionsTotalCount', 'InteractionsThumbUp', 'InteractionsThumbDown']


#make a csv file of the data
with open('/home/pi/VE/resit.csv.csv', 'w') as outcsv:
    writer = csv.writer(outcsv, delimiter=';')
    writer.writerow(header)        
    
#main recommendation csv file 
    for row in sortedrecommendations:
        writer.writerow(row)



###conclusion: in this file you see all the recommendations of the author of interstellar. Enjoy the results Rob!
