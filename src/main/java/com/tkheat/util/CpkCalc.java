package com.tkheat.util;

import java.util.ArrayList;

public class CpkCalc {
	/*
	시료크기(n)A2/		D3/		D4/		d2/		d3/		
	2/		1.88/	./		3.27/	1.128/	0.853
	3/		1.07/	./		2.57/	1.693/	0.888
	4/		0.73/	./		2.28/	2.059/	0.880
	5/		0.58/	./		2.11/	2.326/	0.864
	6/		0.48/	./		2.00/	2.534/	0.848
	7/		0.42/	0.08/	1.92/
	8/		0.37/	0.14/	1.86/
	9/		0.34/	0.18/	1.82/
	10/		0.31/	0.12/	1.78/	
	*/

	//(((xm_sum/xm_idx)*100/100.0))
	
	ArrayList<String> xm_AVGList = new ArrayList<String>();
	ArrayList<String> rangeList = new ArrayList<String>();

	public double d3 (int n){
		double result = 0.0;
		
		switch(n){
		case 2: result = 0.853; break;
		case 3: result = 0.888; break;
		case 4: result = 0.880; break;
		case 5: result = 0.864; break;
		case 6: result = 0.848; break;
		}
		
		return result;
	}	
	
	
	public double d4 (int n){
		double result = 0.0;
		
		switch(n){
		case 2: result = 3.27; break;
		case 3: result = 2.574; break;
		case 4: result = 2.28; break;
		case 5: result = 2.11; break;
		case 6: result = 2.00; break;
		case 7: result = 1.92; break;
		case 8: result = 1.86; break;
		case 9: result = 1.82; break;
		case 10: result = 1.78; break;
		}
		
		return result;
	}	
		
	
	public double d2 (int n){
		double result = 0.0;
		
		switch(n){
		case 2: result = 1.128; break;
		case 3: result = 1.693; break;
		case 4: result = 2.059; break;
		case 5: result = 2.326; break;
		case 6: result = 2.534; break;
		}
		
		return result;
	}	
	
	
	public double a2 (int n){
		double result = 0.0;
		
		switch(n){
		case 2: result = 1.88; break;
		case 3: result = 1.023; break;
		case 4: result = 0.73; break;
		case 5: result = 0.58; break;
		case 6: result = 0.48; break;
		case 7: result = 0.42; break;
		case 8: result = 0.37; break;
		case 9: result = 0.34; break;
		case 10: result = 0.31; break;
		}
		
		return result;
	}
	
	
	
	
	//Xm평균값 : 하루에 나온결과값의 평균 구하기
	public String xm_average(double xm_sum, int xm_idx){
//		//System.out.println("평균값 : "+xm_sum/xm_idx);
		String result = String.format("%.2f",xm_sum/xm_idx);
		xm_AVGList.add(result);
		
		return result;
	}
	
	
	//Xm평균값 : 하루에 나온결과값의 평균 구하기(리스트 추가없이 리턴만)
	public String xm_average2(double xm_sum, int xm_idx){
		
		String result = String.format("%.2f",xm_sum/xm_idx);
//		xm_AVGList.add(result);
		
		return result;
	}
	
	//Range : 하루치의 값중 최대 - 최소의 범위
	public String xm_range(double x1, double x2, double x3){
		double range = 0.0;
		String result = "";
//		//System.out.println(x1+", "+x2+", "+x3);
		if(x1 == 0.0 && x2 == 0.0 && x3 == 0.0){
			return "0";
		}else if(x2 == 0.0 && x3 == 0.0){
			result = "0";
			rangeList.add(result);
			return result;
		}
		
		double max = x1;
		
		if(max < x2){
			max = x2;
		}
		if(max < x3 && x3 != 0.0){
			max = x3;
		}
		
		double min = x1;
		if(min > x2){
			min = x2;
		}
		if(min > x3 && x3 != 0.0){
			min = x3;
		}
		
		range = max - min;
//		//System.out.println("max : "+max+", min : "+min+", range : "+String.format("%.2f",(((range)*100/100.0))));
		
//		(((xm_sum/xm_idx)*100/100.0))		
		result = String.format("%.2f",range);
		rangeList.add(result);
		
		return result;
	}
	
	//Range : 하루치의 값중 최대 - 최소의 범위(리스트 추가없이 값만 리턴)
	public String xm_range2(double x1, double x2, double x3){
		double range = 0.0;
		String result = "";
//		//System.out.println(x1+", "+x2+", "+x3);
		if(x1 == 0.0 && x2 == 0.0 && x3 == 0.0){
			return "0";
		}else if(x2 == 0.0 && x3 == 0.0){
			result = "0";
			rangeList.add(result);
			return result;
		}
		
		double max = x1;
		
		if(max < x2){
			max = x2;
		}
		if(max < x3 && x3 != 0.0){
			max = x3;
		}
		
		double min = x1;
		if(min > x2){
			min = x2;
		}
		if(min > x3 && x3 != 0.0){
			min = x3;
		}
		
		range = max - min;
//		//System.out.println("max : "+max+", min : "+min+", range : "+String.format("%.2f",(((range)*100/100.0))));
		
//		(((xm_sum/xm_idx)*100/100.0))		
		result = String.format("%.2f",range);
//		rangeList.add(result);
		
		return result;
	}
	
	//Xbar : 평균값들의 평균
	public String xbar_average(){
//		//System.out.println("평균 크기 : "+xm_AVGList.size());
		double sum = 0.0;
		for(int i=0; i<xm_AVGList.size(); i++){
//			//System.out.println("평균의 평균 : "+xm_AVGList.get(i));
			sum += Double.parseDouble(xm_AVGList.get(i));
		}
		
		String result = String.format("%.2f",Math.round(sum/xm_AVGList.size()*100)/100.0);
		
		return result;
	}
	
	//Rm : Range값들의 평균
	public String range_average(){
		double sum = 0.0;
		for(int i=0; i<rangeList.size(); i++){
			sum += Double.parseDouble(rangeList.get(i));
//			//System.out.println((i+1)+" : "+rangeList.get(i));
		}
		
		String result = String.format("%.2f",sum/rangeList.size());
		
		return result;
	}
	
	
	
	/*X Bar*/
	//UCL : Xbar + (1.07*Rm)
	
	//Xbar : Xm 평균값
	//a2
	//rm : 범위의 평균값
	public String x_Bar_UCL(int n){
		
		String xBar = xbar_average();
		String rm = range_average();
		double a2 = a2(n);
		
		String result = String.format("%.5f",Double.parseDouble(xBar) + 1.023*Double.parseDouble(rm));
		
		return result;
	}
	
	//CL : Xbar
	public String x_Bar_CL(){
		double xBar = Double.parseDouble(xbar_average());
		
		String result = String.format("%.5f",xBar);
		
		return result;		
	}
	
		
	
	//LCL : Xbar - (0.58*Rm)
	public String x_Bar_LCL(int n){
		String xBar = xbar_average();
		String rm = range_average();
		double a2 = a2(n);
		
		String result = String.format("%.5f",Double.parseDouble(xBar) - 1.023*Double.parseDouble(rm));
		
		return result;		
		
	}
	
	/*R*/
	//UCL : 2.11 * Rm
	//2.11은 d4
	public String r_UCL(int n){
		String rm = range_average();
		double d4 = d4(n);
		
		String result = String.format("%.5f",Double.parseDouble(rm) * 2.574);
		
		return result;
	}
	
	//CL : Rm
	public String r_CL(){
		double rm = Double.parseDouble(range_average());
		
		String result = String.format("%.5f",rm);
		
		return result;		
	}
	
	//Rbar/d2 : Rm/0.888 or 1.693
	public String r_Bar_d2(int n, int m){
		double rm = Double.parseDouble(range_average());	
		
		double r_bar = 0.0;
		
		if(n == 3){
//			r_bar = rm / d2(3);
			r_bar = rm / 1.693;
		}else if(n == 5){
			r_bar = rm / d2(3);
		}
		
		String result = String.format("%.3f",r_bar);
		
//		calculateStandardDeviationPopulation(xm_AVGList);
		
		return result;		
	}
	
	public String r_Bar_d2(int n) {
		ArrayList<String> data = xm_AVGList;
		
	    double mean = calculateMean(data);
	    double sumOfSquares = 0;
	    
	    for(int i=0; i<data.size(); i++){
	    	sumOfSquares += Math.pow(Double.parseDouble(data.get(i)) - mean, 2);
	    }
	    
	    return String.format("%.3f",Math.sqrt(sumOfSquares / data.size()));
	}
	
	

	public double calculateMean(ArrayList<String> data) {
	    double sum = 0;
	    for(int i=0; i<data.size(); i++){
	    	sum += Double.parseDouble(data.get(i));
	    }
	    return sum / data.size();
	}	
	
	
	//CP : (경도SPEC 상한-하한)/ r_d2
	//(UpperSpec - LowerSpec) / (6 * (R평균 / d2))
	public String cp(double max, double min, int n){
		double r_Bar_d2 = Double.parseDouble(r_Bar_d2(n));
		double rm = Double.parseDouble(range_average());
		
//		String result = String.format("%.5f",(max - min)/r_Bar_d2);

		String result = String.format("%.3f",(max - min)/(6 * Double.parseDouble(r_Bar_d2(3))));

		return result;
	}
	
	
	//(ABS((X3+X4)/2-C10))/((X3-X4)/2)
	//k : 절댓값 |((경도SPEC상한+하한)/2-Xbar CL)|/((경도SPEC상한-하한)/2)
	public String k(double max, double min){
		double  xbar_cl = Double.parseDouble(x_Bar_CL());
		
		String result = String.format("%.3f",Math.abs((max+min)/2-xbar_cl)/((max-min)/2));
		
		return result;
	}
	
	
	
	//CPk : (1-0.0940) * 3.9091 -> (1-k) * Cp
	public String cpk(double max, double min, int n){
		double cp = Double.parseDouble(cp(max,min,n));
		double k = Double.parseDouble(k(max,min));
		
		String result = String.format("%.3f",(1-k) * cp);
		
		return result;
	}
	
	//a : xBAR (UCL-LCL)/6
	public String a(int n){
		double ucl = Double.parseDouble(x_Bar_UCL(n));
		double lcl = Double.parseDouble(x_Bar_LCL(n));
				
		String result = String.format("%.3f",(ucl-lcl)/6);
		
		return result;
	}
	

}
