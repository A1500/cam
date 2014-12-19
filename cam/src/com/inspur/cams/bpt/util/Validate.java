package com.inspur.cams.bpt.util;

import java.math.BigDecimal;

/**
 * 读取校验 *
 * 
 * @author wang_yong
 * 
 */
public class Validate {

	public static void main(String[] args) {

	}

	/**
	 * 判断15,18位,其他不校验 
	 * @param id_card
	 * @return "0,身份证号码"或"1,身份证号码"
	 * 
	 */
	public static String[] is_id_card(String id_card) {
		String[] a = { "", ""};
		
		id_card = id_card == null ? "" : id_card;
		if (id_card.length() == 15 || id_card.length() == 18) {
			a[0] = "1";
			a[1] = id_card;
			return a;
		} else {
			a[0] = "0";
			a[1] = id_card;
			return a;
		}
	}
	/**
	 * 判断姓名
	 * @param name
	 * @return "0,错误信息"或"1" 
	 */
	public static String[] is_name(String name) {
		String[] a = { "", ""};
		if (name == null||name.equals("")) {
			a[0] = "0";
			a[1] = "姓名没有录入";
			return a;
		}else
		{
			a[0] = "1";
			a[1] = name;
			return a;
		} 
	}
	/**
	 * 校验性别
	 * 
	 * @param sex
	 * @return "0,错误信息" 或"1" 1：男，2：女
	 */
	public static String[] is_sex(String sex) {
		String[] a = { "", "" };
		sex = sex == null ? "" : sex;
		if (sex.equals("")) {
			a[0] = "0";
			a[1] = "性别没有录入";
			return a;
		}	
		if (sex.equals("男")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		} else if (sex.equals("女")) {
			a[0] = "1";
			a[1] = "2";
			return a;

		} else {
			a[0] = "0";
			a[1] = "性别不正确";
			return a;
		}
	}

	/**
	 * 校验与户主关系
	 * 
	 * @param relationship_type
	 * @return "0,错误信息" 或"1"
	 *         01:户主/本人,10:配偶,20:子/婿,30:女/媳,40:（外）孙子女,50:父母/岳父母/公婆,
	 *         60:（外）祖父母,70:兄弟姐妹,99:其他
	 */
	public static String[] is_relationship_type(String relationship_type) {
		String[] a = { "", "" };
		relationship_type = relationship_type == null ? "" : relationship_type;
		if (relationship_type.equals("")) {
			a[0] = "0";
			a[1] = "与户主关系没有录入";
			return a;
		}		
		if (relationship_type.equals("户主")) {
			a[0] = "1";
			a[1] = "01";
			return a;
		} else if (relationship_type.equals("配偶")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("配偶")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("子")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("女")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("孙子女")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("父母")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("祖父母")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("兄弟姐妹")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else if (relationship_type.equals("其他")) {
			a[0] = "1";
			a[1] = "10";
			return a;

		} else {
			a[0] = "0";
			a[1] = "户主关系输入不对";
			return a;
		}

	}

	/**
	 * 校验户籍类别
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1" 1:农村,2:城镇
	 */
	public static String[] is_domicile_type(String domicile_type) {
		String[] a = { "", "" };
		domicile_type = domicile_type == null ? "" : domicile_type;
		if (domicile_type.equals("")) {
			a[0] = "0";
			a[1] = "户籍类别没有录入";
			return a;
		}		
		if (domicile_type.equals("农村")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		} else if (domicile_type.equals("城镇")) {
			a[0] = "1";
			a[1] = "2";
			return a;

		} else {
			a[0] = "0";
			a[1] = "户籍类别不正确";
			return a;
		}
	}

	/**
	 * 校验户口薄行政区划
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_domicile_code(String domicile_code,
			String organ_code) {
		String[] a = { "", "" };
		if (domicile_code == null) {
			a[0] = "0";
			a[1] = "户口薄行政区划没有录入";
			return a;
		}
		domicile_code = domicile_code == null ? "" : domicile_code;
		//
		if (domicile_code.length() != 12) {
			a[0] = "0";
			a[1] = "户口薄行政区划不正确";
			return a;
		} else {
			if (domicile_code.substring(0, 6)
					.equals(organ_code.substring(0, 6)))// 行政区划前六位必须一致
			{
				// 如果一致，确保此行政区划在dic_city中存在
				if (ReadExcel
						.getCount("select count(*) from dic_city where id='"
								+ domicile_code + "'") == 1) {
					a[0] = "1";
					a[1] = domicile_code;
					return a;
				} else {
					a[0] = "1";
					a[1] = "你录入的户口薄行政区划:" + domicile_code + "不存在";
					return a;
				}
			} else {
				a[0] = "0";
				a[1] = "户口薄行政区划不正确";
				return a;
			}
		}
	}

	/**
	 * 校验居住地行政区划
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_apanage_code(String apanage_code,
			String organ_code) {
		String[] a = { "", "" };
		if (apanage_code == null) {
			a[0] = "0";
			a[1] = "实际居住地行政区划没有录入";
			return a;
		}
		
		apanage_code = apanage_code == null ? "" : apanage_code;
		//
		if (apanage_code.length() != 12) {
			a[0] = "0";
			a[1] = "实际居住地行政区划不正确";
			return a;
		} else {
			// 行政区划前六位必须一致，确保录入的本县的数据，市级用户使用此功能会出错
			if (apanage_code.substring(0, 6).equals(organ_code.substring(0, 6))) {
				// 如果一致，确保此行政区划在dic_city中存在
				if (ReadExcel
						.getCount("select count(*) from dic_city where id='"
								+ apanage_code + "'") == 1) {
					a[0] = "1";
					a[1] = apanage_code;
					return a;
				} else {
					a[0] = "1";
					a[1] = "你录入的居住地行政区划:" + apanage_code + "不存在";
					return a;
				}
			} else {
				a[0] = "0";
				a[1] = "居住地行政区划不正确";
				return a;
			}
		}
	}

	/**
	 * 校验医疗保障方式
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1,返回值"
	 *         1:公费医疗,2:城镇职工基本医疗保险,3:城镇居民基本医疗保险,4:新型农村合作医疗,5:其他
	 */
	public static String[] is_safeguard_type(String safeguard_type) {
		String[] a = { "", "" };
		if (safeguard_type == null) {
			a[0] = "0";
			a[1] = "医疗保障方式没有录入";
			return a;
		}
		safeguard_type = safeguard_type == null ? "" : safeguard_type;
		if (safeguard_type.equals("公费医疗")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		} else if (safeguard_type.equals("城镇职工基本医疗保险")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		} else if (safeguard_type.equals("城镇居民基本医疗保险")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		} else if (safeguard_type.equals("新型农村合作医疗")) {
			a[0] = "1";
			a[1] = "4";
			return a;
		} else if (safeguard_type.equals("其他")) {
			a[0] = "1";
			a[1] = "5";
			return a;
		} else {
			a[0] = "0";
			a[1] = "医疗保障方式录入不正确";
			return a;
		}
	}
	/**
	 * 校验养老保障方式
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1,返回值"
	 *1:新型农村养老保险,2:城镇居民养老保险,3:城镇职工基本养老保险,4:商业保险,6:社会统筹,7:其他,5:无
	 *1:新型农村养老保险,2:城镇居民养老保险,3:城镇职工基本养老保险,4:商业保险,6:社会统筹,7:其他,5:无
	 */
	public static String[] is_pension_code(String pension_code) {
		String[] a = { "", "" };		
		if (pension_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		pension_code = pension_code == null ? "" : pension_code;
		if (pension_code.equals("新型农村养老保险")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		} else if (pension_code.equals("城镇居民养老保险")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		} else if (pension_code.equals("城镇职工基本养老保险")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		} else if (pension_code.equals("商业保险")) {
			a[0] = "1";
			a[1] = "4";
			return a;
		} else if (pension_code.equals("社会统筹")) {
			a[0] = "1";
			a[1] = "6";
			return a;
		} else if (pension_code.equals("其他")) {
			a[0] = "1";
			a[1] = "7";
			return a;
		} else if (pension_code.equals("无")) {
			a[0] = "1";
			a[1] = "5";
			return a;
		}else {
			a[0] = "0";
			a[1] = "养老保障方式录入不正确";
			return a;
		}
	}
	/**
	 * 校验邮政编码，允许为空
	 * 
	 * @param domicile_type
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_post_code(String post_code) {
		String[] a = { "", "" };		
		if (post_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		post_code = post_code == null ? "" : post_code;
		if (post_code.length()<=6) {
			a[0] = "1";
			a[1] = post_code;
			return a;
		}else {
			a[0] = "0";
			a[1] = "邮政编码录入不正确";
			return a;
		}
	}
	/**
	 * 校验婚姻状况,允许为空
	 * 
	 * @param marriage_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 10:未婚,20:已婚,30:丧偶,40:离婚
	 */
	public static String[] is_marriage_code(String marriage_code) {
		String[] a = { "", "" };		
		if (marriage_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		marriage_code = marriage_code == null ? "" : marriage_code;
		if (marriage_code.equals("未婚")) {
			a[0] = "1";
			a[1] = "10";
			return a;
		}if (marriage_code.equals("已婚")) {
			a[0] = "1";
			a[1] = "20";
			return a;
		}if (marriage_code.equals("丧偶")) {
			a[0] = "1";
			a[1] = "30";
			return a;
		}if (marriage_code.equals("离婚")) {
			a[0] = "1";
			a[1] = "40";
			return a;
		}else {
			a[0] = "0";
			a[1] = "婚姻状况录入不正确";
			return a;
		}
	}
	/**
	 * 校验文化程度 
	 * @param edu_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 10:研究生,20:大学本科,30:大学专科和专科学校,40:中等专业学校或中等技术学校,50:技工学校,
	 * 60:高中,70:初中,80:小学,90:文盲或半文盲
	 */
	public static String[] is_edu_code(String edu_code) {
		String[] a = { "", "" };		
		if (edu_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		edu_code = edu_code == null ? "" : edu_code;
		if (edu_code.equals("研究生")) {
			a[0] = "1";
			a[1] = "10";
			return a;
		}if (edu_code.equals("大学本科")) {
			a[0] = "1";
			a[1] = "20";
			return a;
		}if (edu_code.equals("大学专科和专科学校")) {
			a[0] = "1";
			a[1] = "30";
			return a;
		}if (edu_code.equals("中等专业学校或中等技术学校")) {
			a[0] = "1";
			a[1] = "40";
			return a;
		}if (edu_code.equals("技工学校")) {
			a[0] = "1";
			a[1] = "50";
			return a;
		}if (edu_code.equals("高中")) {
			a[0] = "1";
			a[1] = "60";
			return a;
		}if (edu_code.equals("初中")) {
			a[0] = "1";
			a[1] = "70";
			return a;
		}if (edu_code.equals("小学")) {
			a[0] = "1";
			a[1] = "80";
			return a;
		}if (edu_code.equals("文盲或半文盲")) {
			a[0] = "1";
			a[1] = "90";
			return a;
		}else {
			a[0] = "0";
			a[1] = "文化程度录入不正确";
			return a;
		}
	}
	/**
	 * 校验健康状况
	 * @param edu_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 10:健康或良好,20:一般或较弱,30:有慢性病,60:残疾
	 */
	public static String[] is_health_code(String health_code) {
		String[] a = { "", "" };		
		if (health_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		health_code = health_code == null ? "" : health_code;
		if (health_code.equals("健康或良好")) {
			a[0] = "1";
			a[1] = "10";
			return a;
		}if (health_code.equals("一般或较弱")) {
			a[0] = "1";
			a[1] = "20";
			return a;
		}if (health_code.equals("有慢性病")) {
			a[0] = "1";
			a[1] = "30";
			return a;
		}if (health_code.equals("残疾")) {
			a[0] = "1";
			a[1] = "40";
			return a;
		}else {
			a[0] = "0";
			a[1] = "健康状况录入不正确";
			return a;
		}
	}
	
	/**
	 * 校验政治面貌
	 * @param political_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 01:中国共产党党员,02:中国共产党预备党员,03:中国国民党革命委员会会员,04:中国民主同盟盟员,05:中国民主建国会会员,06:中国民主促进会会员,07:中国农工民主党党员,
	 * 08:中国致公党党员,09:九三学社社员,10:台湾民主自治同盟盟员,11:无党派民主人士,12:群众
	 */
	public static String[] is_political_code(String political_code) {
		String[] a = { "", "" };		
		if (political_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		political_code = political_code == null ? "" : political_code;
		if (political_code.equals("中国共产党党员")) {
			a[0] = "1";
			a[1] = "01";
			return a;
		}if (political_code.equals("中国共产党预备党员")) {
			a[0] = "1";
			a[1] = "02";
			return a;
		}if (political_code.equals("中国国民党革命委员会会员")) {
			a[0] = "1";
			a[1] = "03";
			return a;
		}if (political_code.equals("中国民主同盟盟员")) {
			a[0] = "1";
			a[1] = "04";
			return a;
		}if (political_code.equals("中国民主建国会会员")) {
			a[0] = "1";
			a[1] = "05";
			return a;
		}if (political_code.equals("中国民主促进会会员")) {
			a[0] = "1";
			a[1] = "06";
			return a;
		}if (political_code.equals("中国农工民主党党员")) {
			a[0] = "1";
			a[1] = "07";
			return a;
		}if (political_code.equals("中国致公党党员")) {
			a[0] = "1";
			a[1] = "08";
			return a;
		}if (political_code.equals("九三学社社员")) {
			a[0] = "1";
			a[1] = "09";
			return a;
		}if (political_code.equals("台湾民主自治同盟盟员")) {
			a[0] = "1";
			a[1] = "10";
			return a;
		}if (political_code.equals("无党派民主人士")) {
			a[0] = "1";
			a[1] = "11";
			return a;
		}if (political_code.equals("群众")) {
			a[0] = "1";
			a[1] = "12";
			return a;
		}else {
			a[0] = "0";
			a[1] = "政治面貌录入不正确";
			return a;
		}
	}
	/**
	 * 校验就业状况
	 * @param employment_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 11:在职（机关事业）,12:在职（企业）,13:在职（困难企业）,21:离休,22:退休,41:经商,61:失业,71:无工作,99:其他
	 */
	public static String[] is_employment_code(String employment_code) {
		String[] a = { "", "" };		
		if (employment_code == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		employment_code = employment_code == null ? "" : employment_code;
		if (employment_code.equals("在职（机关事业）")) {
			a[0] = "1";
			a[1] = "11";
			return a;
		}if (employment_code.equals("在职（企业）")) {
			a[0] = "1";
			a[1] = "12";
			return a;
		}if (employment_code.equals("在职（困难企业）")) {
			a[0] = "1";
			a[1] = "13";
			return a;
		}if (employment_code.equals("离休")) {
			a[0] = "1";
			a[1] = "21";
			return a;
		}if (employment_code.equals("退休")) {
			a[0] = "1";
			a[1] = "22";
			return a;
		}if (employment_code.equals("经商")) {
			a[0] = "1";
			a[1] = "41";
			return a;
		}if (employment_code.equals("失业")) {
			a[0] = "1";
			a[1] = "61";
			return a;
		}if (employment_code.equals("无工作")) {
			a[0] = "1";
			a[1] = "71";
			return a;
		}if (employment_code.equals("其他")) {
			a[0] = "1";
			a[1] = "99";
			return a;
		}else {
			a[0] = "0";
			a[1] = "就业状况录入不正确";
			return a;
		}
	}
	/**
	 * 校验收入
	 * @param edu_code
	 * @return "0,错误信息" 或"1,返回值"
	 */
	public static String[] is_income_year(String income_year) {
		String[] a = { "", "" };		
		if (income_year == null) {
			a[0] = "1";
			a[1] = "";
			return a;
		}
		income_year = income_year == null ? "" : income_year;
		try{
			new BigDecimal(income_year);
			a[0] = "1";
			a[1] = income_year;
			return a;
		}catch(Exception e)
		{
			a[0] = "0";
			a[1] = "年收入录入不正确";
			return a;
		}		
	}
	/**
	 * 是否孤老,必录项
	 * @param old_lonely_flag
	 * @return "0,错误信息" 或"1,返回值"
	 * 0:否,1:是
	 */
	public static String[] is_old_lonely_flag(String old_lonely_flag) {
		String[] a = { "", "" };		
		if (old_lonely_flag == null) {
			a[0] = "0";
			a[1] = "没有录入是否孤老";
			return a;
		}else
		{	
			if(old_lonely_flag.equals("否"))
			{
				a[0] = "1";
				a[1] = "0";
				return a;
			}
			else if(old_lonely_flag.equals("是"))
			{
				a[0] = "1";
				a[1] = "1";
				return a;
			}else
			{
				a[0] = "0";
				a[1] = "是否孤老录入不正确";
				return a;
			}
		}
	}
	/**
	 * 是否精神病,必录项
	 * @param old_lonely_flag
	 * @return "0,错误信息" 或"1,返回值"
	 * 0:否,1:是
	 */
	public static String[] is_insanity_flag(String insanity_flag) {
		String[] a = { "", "" };		
		if (insanity_flag == null) {
			a[0] = "0";
			a[1] = "没有录入是否经生病";
			return a;
		}else
		{	
			if(insanity_flag.equals("否"))
			{
				a[0] = "1";
				a[1] = "0";
				return a;
			}
			else if(insanity_flag.equals("是"))
			{
				a[0] = "1";
				a[1] = "1";
				return a;
			}else
			{
				a[0] = "0";
				a[1] = "是否精神病录入不正确";
				return a;
			}
		}
	}
	/**
	 * 校验劳动能力,必录项
	 * @param work_ability_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:有劳动能力,2:部分丧失劳动能力,3:完全丧失劳动能力
	 */
	public static String[] is_work_ability_code(String work_ability_code) {
		String[] a = { "", "" };		
		if (work_ability_code == null) {
			a[0] = "0";
			a[1] = "没有录入劳动能力";
			return a;
		}
		work_ability_code = work_ability_code == null ? "" : work_ability_code;
		if (work_ability_code.equals("有劳动能力")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (work_ability_code.equals("部分丧失劳动能力")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}if (work_ability_code.equals("完全丧失劳动能力")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		}else {
			a[0] = "0";
			a[1] = "劳动能力录入不正确";
			return a;
		}
	}
	/**
	 * 校验生活能力,必录项
	 * @param viability_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:自理,2:享受护理
	 */
	public static String[] is_viability_code(String viability_code) {
		String[] a = { "", "" };		
		if (viability_code == null) {
			a[0] = "0";
			a[1] = "没有录入生活能力";
			return a;
		}
		viability_code = viability_code == null ? "" : viability_code;
		if (viability_code.equals("自理")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (viability_code.equals("享受护理")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}else {
			a[0] = "0";
			a[1] = "生活能力录入不正确";
			return a;
		}
	}
	/**
	 * 校验供养方式,必录项
	 * @param support_pattern
	 * @return "0,错误信息" 或"1,返回值"
	 * 1:分散供养,2:优抚医院,3:精神病院,4:光荣院,5:敬老院,6:其他
	 */
	public static String[] is_support_pattern(String support_pattern) {
		String[] a = { "", "" };		
		if (support_pattern == null) {
			a[0] = "0";
			a[1] = "没有录入供养方式";
			return a;
		}
		support_pattern = support_pattern == null ? "" : support_pattern;
		if (support_pattern.equals("分散供养")) {
			a[0] = "1";
			a[1] = "1";
			return a;
		}if (support_pattern.equals("优抚医院")) {
			a[0] = "1";
			a[1] = "2";
			return a;
		}if (support_pattern.equals("精神病院")) {
			a[0] = "1";
			a[1] = "3";
			return a;
		}if (support_pattern.equals("光荣院")) {
			a[0] = "1";
			a[1] = "4";
			return a;
		}if (support_pattern.equals("敬老院")) {
			a[0] = "1";
			a[1] = "5";
			return a;
		}if (support_pattern.equals("其他")) {
			a[0] = "1";
			a[1] = "6";
			return a;
		}else {
			a[0] = "0";
			a[1] = "供养方式录入不正确";
			return a;
		}
	}
	/**
	 * 校验开户银行,必录项
	 * @param bank
	 * @return "0,错误信息" 或"1,返回值"
	 * 102:中国工商银行,103:中国农业银行,104:中国银行,105:中国建设银行,301:交通银行,302:中信银行,
	 * 304:华夏银行,308:招商银行,309:中国邮政储蓄银行,401:信用社
	 */
	public static String[] is_bank(String bank) {
		String[] a = { "", "" };		
		if (bank == null) {
			a[0] = "0";
			a[1] = "没有录入开户银行";
			return a;
		}
		bank = bank == null ? "" : bank;
		if (bank.equals("中国工商银行")) {
			a[0] = "1";
			a[1] = "102";
			return a;
		}if (bank.equals("中国农业银行")) {
			a[0] = "1";
			a[1] = "103";
			return a;
		}if (bank.equals("中国银行")) {
			a[0] = "1";
			a[1] = "104";
			return a;
		}if (bank.equals("中国建设银行")) {
			a[0] = "1";
			a[1] = "105";
			return a;
		}if (bank.equals("交通银行")) {
			a[0] = "1";
			a[1] = "301";
			return a;
		}if (bank.equals("中信银行")) {
			a[0] = "1";
			a[1] = "302";
			return a;
		}if (bank.equals("华夏银行")) {
			a[0] = "1";
			a[1] = "304";
			return a;
		}if (bank.equals("招商银行")) {
			a[0] = "1";
			a[1] = "308";
			return a;
		}if (bank.equals("中国邮政储蓄银行")) {
			a[0] = "1";
			a[1] = "309";
			return a;
		}if (bank.equals("信用社")) {
			a[0] = "1";
			a[1] = "401";
			return a;
		}else {
			a[0] = "0";
			a[1] = "开户银行录入不正确";
			return a;
		}
	}
	
	/**
	 * 校验银行账户,必录项
	 * @param account_code
	 * @return "0,错误信息" 或"1,返回值"
	 * 
	 */
	public static String[] is_account_code(String account_code) {
		String[] a = { "", "" };		
		if (account_code == null) {
			a[0] = "0";
			a[1] = "没有录入银行账户";
			return a;
		}else
		{
			a[0] = "1";
			a[1] = account_code;
			return a;
		}
	}
	
}