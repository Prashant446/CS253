NR > 1{
	country=$9
	if(country in list){
		origin = list[country];
		count[country] = count[country] + 1;
		sum[country] = sum[country] + $2;
	} else{
		list[country] = $9; 
		count[country] = 1;
		sum[country] = $2;
	}
}
END{
	for (country in list){
		name = list[country];
		avg = sum[country]/count[country];
		print name;
		print avg;
	}
}
