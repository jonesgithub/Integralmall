package com.doublev2v.integralmall.util;

public class MapPointDistance {

	public static double getPointsDistance(double lng_a,double lat_a,double lng_b,double lat_b){
		double pk = 180 / 3.14169;
		double a1 = lat_a / pk;
		double a2 = lng_a / pk;
		double b1 = lat_b / pk;
		double b2 = lng_b / pk;
		double t1 = Math.cos(a1) * Math.cos(a2) * Math.cos(b1) * Math.cos(b2);
		double t2 = Math.cos(a1) * Math.sin(a2) * Math.cos(b1) * Math.sin(b2);
		double t3 = Math.sin(a1) * Math.sin(b1);
		double tt = Math.acos(t1 + t2 + t3);
		return 6366000 * tt;
	}
}
