package com.inspur.cams.fis.ep.util;

import java.math.BigDecimal;
import org.loushang.next.data.Record;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;

/**
 * @Path com.inspur.cams.fis.ep.util.RecordToBean
 * @Description: TODO 将通过sql查出来的record转换成Bean
 * @author luguosui
 * @date 2011-11-30
 */
public class RecordToBean {
	/**
	 * @Title: getFisCemeCheckInfo
	 * @Description: TODO()
	 * @param
	 * @param record
	 * @param
	 * @return 设定文件
	 * @return FisCemeCheckInfo 返回类型
	 */
	public static FisCemeCheckInfo getFisCemeCheckInfo(Record record) {
		FisCemeCheckInfo dataBean = new FisCemeCheckInfo();
		dataBean.setAddress(toString(record.get("ADDRESS")));
		dataBean.setApplyId(toString(record.get("APPLY_ID")));
		dataBean.setAreaLevel(toString(record.get("AREA_LEVEL")));
		dataBean.setAreaLevelId(toString(record.get("AREA_LEVEL_ID")));
		dataBean.setBuiltArea(toBigDecimal(record.get("BUILT_AREA")));
		dataBean.setBuiltAreaUnits(toString(record.get("BUILT_AREA_UNITS")));
		dataBean.setBuiltTotalArea(toBigDecimal(record.get("BUILT_TOTAL_AREA")));
		dataBean.setCemeId(toString(record.get("CEME_ID")));
		dataBean.setCemeName(toString(record.get("CEME_NAME")));
		dataBean.setCheckNum(toString(record.get("CHECK_NUM")));
		dataBean.setCheckYear(toString(record.get("CHECK_YEAR")));
		dataBean.setDirectorMobile(toString(record.get("DIRECTOR_MOBILE")));
		dataBean.setDoubleHole(toBigDecimal(record.get("DOUBLE_HOLE")));
		dataBean.setFixeDassets(toBigDecimal(record.get("FIXE_DASSETS")));
		dataBean.setGestionTime(toString(record.get("GESTION_TIME")));
		dataBean.setIsReport(toString(record.get("IS_REPORT")));
		dataBean.setLegalPerson(toString(record.get("LEGAL_PERSON")));
		dataBean.setManaLevel(toString(record.get("MANA_LEVEL")));
		dataBean.setManaLevelId(toString(record.get("MANA_LEVEL_ID")));
		dataBean.setMoreHole(toBigDecimal(record.get("MORE_HOLE")));
		dataBean.setNotReasons(toString(record.get("NOT_REASONS")));
		dataBean.setOfficePhone(toString(record.get("OFFICE_PHONE")));
		dataBean.setOrganizer(toString(record.get("ORGANIZER")));
		dataBean.setOutDoubleHole(toBigDecimal(record.get("OUT_DOUBLE_HOLE")));
		dataBean.setOutMoreHole(toBigDecimal(record.get("OUT_MORE_HOLE")));
		dataBean.setOutSingleHole(toBigDecimal(record.get("OUT_SINGLE_HOLE")));
		dataBean.setPostalcode(toString(record.get("POSTALCODE")));
		dataBean.setProp(toString(record.get("PROP")));
		dataBean.setSellDoubleHole(toBigDecimal(record.get("SELL_DOUBLE_HOLE")));
		dataBean.setSellMoreHole(toBigDecimal(record.get("SELL_MORE_HOLE")));
		dataBean.setSellSingleHole(toBigDecimal(record.get("SELL_SINGLE_HOLE")));
		dataBean.setSinceHoleNum(toString(record.get("SINCE_HOLE_NUM")));
		dataBean.setSincePeopleNum(toBigDecimal(record.get("SINCE_PEOPLE_NUM")));
		dataBean.setSingleHole(toBigDecimal(record.get("SINGLE_HOLE")));
		dataBean.setTotalArea(toString(record.get("TOTAL_AREA")));
		dataBean.setTotalAreaUnits(toString(record.get("TOTAL_AREA_UNITS")));
		dataBean.setTotalInvestment(toBigDecimal(record.get("TOTAL_INVESTMENT")));
		dataBean.setTotalStaff(toBigDecimal(record.get("TOTAL_STAFF")));
		dataBean.setUnitProperties(toString(record.get("UNIT_PROPERTIES")));
		dataBean.setWfId(toString(record.get("WF_ID")));
		dataBean.setYearDoubleHole(toBigDecimal(record.get("YEAR_DOUBLE_HOLE")));
		dataBean.setYearHoleNum(toBigDecimal(record.get("YEAR_HOLE_NUM")));
		dataBean.setYearMoreHole(toBigDecimal(record.get("YEAR_MORE_HOLE")));
		dataBean.setYearOutNum(toString(record.get("YEAR_OUT_NUM")));
		dataBean.setYearPeopleNum(toBigDecimal(record.get("YEAR_PEOPLE_NUM")));
		dataBean.setYearSellNum(toBigDecimal(record.get("YEAR_SELL_NUM")));
		dataBean.setYearSingleHole(toBigDecimal(record.get("YEAR_SINGLE_HOLE")));
		
		dataBean.setFundSources(toString(record.get("FUND_SOURCES")));
		dataBean.setServiceScope(toString(record.get("SERVICE_SCOPE")));
		return dataBean;
	}
	
	public static String toString(Object obj) {
		try {
			return obj.toString();
		}catch(Exception e){}

		return "";
	}
	
	public static BigDecimal toBigDecimal(Object obj) {
		try {
			return (BigDecimal)obj;
		}catch(Exception e){}

		return new BigDecimal(0);
	}
}
