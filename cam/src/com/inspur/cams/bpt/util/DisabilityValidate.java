package com.inspur.cams.bpt.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 伤残数据校验 
 * @author wang_yong
 * 
 */
public class DisabilityValidate extends Validate {

	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {

	}
	/**
	 * 校验伤残类别
	 * @param disability_type_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 11:残疾军人,12:伤残国家机关工作人员,13:伤残人民警察,14:伤残民兵民工,15:因战因公伤残人员
	 */
	public static String[] is_disability_type_code(String disability_type_code) {
		String[] a = { "", "" };		
		if (disability_type_code == null) {
			a[0] = "0";
			a[1] = "没有录入伤残类别";
			return a;
		}
		disability_type_code = disability_type_code == null ? "" : disability_type_code;
		if (disability_type_code.equals("残疾军人")) {
			a[0] = "1";
			a[1] = "11";
			return a;
		}if (disability_type_code.equals("伤残国家机关工作人员")) {
			a[0] = "1";
			a[1] = "12";
			return a;
		}if (disability_type_code.equals("伤残人民警察")) {
			a[0] = "1";
			a[1] = "13";
			return a;
		}if (disability_type_code.equals("伤残民兵民工")) {
			a[0] = "1";
			a[1] = "14";
			return a;
		}if (disability_type_code.equals("因战因公伤残人员")) {
			a[0] = "1";
			a[1] = "15";
			return a;
		}else {
			a[0] = "0";
			a[1] = "伤残类别录入不正确";
			return a;
		}
	}
	/**
	 * 校验伤残等级
	 * @param disability_level_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 01:一级,02:二级,03:三级,04:四级,05:五级,06:六级,07:七级,08:八级,09:九级,10:十级
	 */
	public static String[] is_disability_level_code(String disability_level_code) {
		String[] a = { "", "" };		
		if (disability_level_code == null) {
			a[0] = "0";
			a[1] = "没有录入伤残等级";
			return a;
		}
		disability_level_code = disability_level_code == null ? "" : disability_level_code;
		if (disability_level_code.equals("一级")) {
			a[0] = "1";
			a[1] = "01";
			return a;
		}if (disability_level_code.equals("二级")) {
			a[0] = "1";
			a[1] = "02";
			return a;
		}if (disability_level_code.equals("三级")) {
			a[0] = "1";
			a[1] = "03";
			return a;
		}if (disability_level_code.equals("四级")) {
			a[0] = "1";
			a[1] = "04";
			return a;
		}if (disability_level_code.equals("五级")) {
			a[0] = "1";
			a[1] = "05";
			return a;
		}if (disability_level_code.equals("六级")) {
			a[0] = "1";
			a[1] = "06";
			return a;
		}if (disability_level_code.equals("七级")) {
			a[0] = "1";
			a[1] = "07";
			return a;
		}if (disability_level_code.equals("八级")) {
			a[0] = "1";
			a[1] = "08";
			return a;
		}if (disability_level_code.equals("九级")) {
			a[0] = "1";
			a[1] = "09";
			return a;
		}if (disability_level_code.equals("十级")) {
			a[0] = "1";
			a[1] = "10";
			return a;
		}else {
			a[0] = "0";
			a[1] = "伤残等级录入不正确";
			return a;
		}
	}
	/**
	 * 校验伤残性质，必须录入
	 * @param disability_case_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:因战,2:因公,3:因病
	 */
	public static String[] is_disability_case_code(String disability_case_code) {
		String[] a = { "", "" };		
		if (disability_case_code == null) {
			a[0] = "0";
			a[1] = "没有录入伤残性质";
			return a;
		}
		disability_case_code = disability_case_code == null ? "" : disability_case_code;
		if (disability_case_code.equals("因战")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (disability_case_code.equals("因公")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}if (disability_case_code.equals("因公")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		}else {
			a[0] = "0";
			a[1] = "伤残性质录入不正确";
			return a;
		}
	}
	//
	/**必录项
	 * 校验优抚对象状态，只允许录入享受待遇,身份认定不享受待遇,停发,不予认定
	 * @param disability_state_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:受理,2:享受待遇,3:身份认定不享受待遇,4:停发,5:迁移,6:不予认定,7:去世,8:取消,9:中止
	 */
	public static String[] is_disability_state_code(String disability_state_code) {
		String[] a = { "", "" };		
		if (disability_state_code == null) {
			a[0] = "0";
			a[1] = "没有录入优抚对象状态";
			return a;
		}
		disability_state_code = disability_state_code == null ? "" : disability_state_code;
		if (disability_state_code.equals("享受待遇")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}if (disability_state_code.equals("身份认定不享受待遇")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		}if (disability_state_code.equals("停发")) {
			a[0] = "1";
			a[1] = "4";
			return a;
		}if (disability_state_code.equals("迁移")) {
			a[0] = "1";
			a[1] = "5";
			return a;
		}if (disability_state_code.equals("不予认定")) {
			a[0] = "1";
			a[1] = "6";
			return a;
		}else {
			a[0] = "0";
			a[1] = "优抚对象状态录入不正确";
			return a;
		}
	}
	/**
	 * 校验证书编号，必录项
	 * @param disability_no
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_disability_no(String disability_no) {
		String[] a = { "", "" };		
		if (disability_no == null) {
			a[0] = "0";
			a[1] = "没有录入证书编号";
			return a;
		}else
		{
			a[0] = "1";
			a[1] = disability_no;
			return a;
		}
	}
	/**
	 * 校验批准日期，必录项
	 * @param approve_date
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_approve_date(String approve_date) {
		String[] a = { "", "" };		
		if (approve_date == null) {
			a[0] = "0";
			a[1] = "没有录入批准日期";
			return a;
		}else
		{			
			try{			
				
				SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd",Locale.ENGLISH);
				Date	d =new Date(approve_date);
				approve_date=sdfDay.format(d);  // 2007-01-18    
				//sdfDay.parse(approve_date);
				a[0] = "1";
				a[1] = approve_date;
				return a;
			}catch(Exception e){
				e.printStackTrace();
				a[0] = "0";
				a[1] = "批准日期录入不正确";
				return a;
			}			
		}
	}
	/**
	 * 校验入伍（参加工作）时间，必录项
	 * @param conscript_date
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_conscript_date(String conscript_date) {
		String[] a = { "", "" };		
		if (conscript_date == null) {
			a[0] = "0";
			a[1] = "没有录入入伍（参加工作）时间";
			return a;
		}else
		{			
			try{				
				SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
				Date	d =new Date(conscript_date);
				conscript_date=sdfDay.format(d);  // 2007-01-18    
				//sdfDay.parse(conscript_date);
				a[0] = "1";
				a[1] = conscript_date;
				return a;
			}catch(Exception e){
				a[0] = "0";
				a[1] = "入伍（参加工作）时间录入不正确";
				return a;
			}			
		}
	}
	/**
	 * 校验伤残时期，必录项
	 * @param disability_war_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:抗日战争,2:解放战争,4:抗美援朝,3:建国后
	 */
	public static String[] is_disability_war_code(String disability_war_code) {
		String[] a = { "", "" };		
		if (disability_war_code == null) {
			a[0] = "0";
			a[1] = "没有录入伤残时期";
			return a;
		}
		disability_war_code = disability_war_code == null ? "" : disability_war_code;
		if (disability_war_code.equals("抗日战争")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (disability_war_code.equals("解放战争")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}if (disability_war_code.equals("建国后")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		}if (disability_war_code.equals("抗美援朝")) {
			a[0] = "1";
			a[1] = "4";
			return a;
		}else {
			a[0] = "0";
			a[1] = "伤残时期录入不正确";
			return a;
		}
	}
	/**
	 * 校验伤残属别，必录项
	 * @param disability_genus_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:在乡,2:在职
	 */
	public static String[] is_disability_genus_code(String disability_genus_code) {
		String[] a = { "", "" };		
		if (disability_genus_code == null) {
			a[0] = "0";
			a[1] = "没有录入伤残属别";
			return a;
		}
		disability_genus_code = disability_genus_code == null ? "" : disability_genus_code;
		if (disability_genus_code.equals("在乡")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (disability_genus_code.equals("在职")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}else {
			a[0] = "0";
			a[1] = "伤残属别录入不正确";
			return a;
		}
	}
	/**
	 * 校验退伍时间,非必录项
	 * @param veterans_date
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_veterans_date(String veterans_date) {
		String[] a = { "", "" };		
		if (veterans_date == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}else
		{			
			try{				
				SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
				//sdfDay.parse(veterans_date);
				Date	d =new Date(veterans_date);
				veterans_date=sdfDay.format(d);  // 2007-01-18    
				a[0] = "1";
				a[1] = veterans_date;
				return a;
			}catch(Exception e){
				a[0] = "0";
				a[1] = "退伍时间录入不正确";
				return a;
			}			
		}
	}
	/**
	 * 校验离退休时间,非必录项
	 * @param retired_date
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_retired_date(String retired_date) {
		String[] a = { "", "" };		
		if (retired_date == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}else
		{			
			try{				
				SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
				Date	d =new Date(retired_date);
				retired_date=sdfDay.format(d); 
				//sdfDay.parse(retired_date);
				a[0] = "1";
				a[1] = retired_date;
				return a;
			}catch(Exception e){
				a[0] = "0";
				a[1] = "离退休时间录入不正确";
				return a;
			}			
		}
	}
	/**
	 * 校验致残地点,必录项
	 * @param disability_add
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_disability_add(String disability_add) {
		String[] a = { "", "" };		
		if (disability_add == null) {
			a[0] = "1";
			a[1] = "没有录入致残地点";
			return a;
		}else
		{			
			a[0] = "1";
			a[1] = disability_add;
			return a;	
		}
	}
	/**
	 * 校验致残部位,必录项
	 * @param disability_body
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_disability_body(String disability_body) {
		String[] a = { "", "" };		
		if (disability_body == null) {
			a[0] = "1";
			a[1] = "没有录入致残部位";
			return a;
		}else
		{			
			a[0] = "1";
			a[1] = disability_body;
			return a;	
		}
	}
	/**
	 * 校验致残原因,必录项
	 * @param disability_reason
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_disability_reason(String disability_reason) {
		String[] a = { "", "" };		
		if (disability_reason == null) {
			a[0] = "1";
			a[1] = "没有录入致残原因";
			return a;
		}else
		{			
			a[0] = "1";
			a[1] = disability_reason;
			return a;	
		}
	}
}