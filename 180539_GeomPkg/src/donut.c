#include <circle.h>
#include <donut.h>
#include<stdlib.h>
#include<stdio.h>

void read_donut(Donut *d) {
	printf("Inner radius? ");
	scanf("%f", &d->inner.rad);
	printf("Outer radius? ");
	scanf("%f", &d->outer.rad);
	if (d->inner.rad >= d->outer.rad) {
		fprintf(stderr, "Invalid inputs: Outer radius should be strictly grater than inner radius\n");
		exit(-1);
	}
	return;
}

float donut_area(Donut *d) {
	return (circ_area(&d->outer) - circ_area(&d->inner));
}

float donut_peri(Donut *d) {
	return (circ_perimtr(&d->outer) + circ_perimtr(&d->inner));
}
