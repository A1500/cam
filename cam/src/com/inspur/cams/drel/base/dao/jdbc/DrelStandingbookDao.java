package com.inspur.cams.drel.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.base.dao.IDrelStandingbookDao;
import com.inspur.cams.drel.base.data.DrelStandingbook;

/**
 * 台账表dao
 * @author 
 * @date 2013-09-09
 */
public class DrelStandingbookDao extends EntityDao<DrelStandingbook> implements IDrelStandingbookDao {
	
	@Override
	public Class<DrelStandingbook> getEntityClass() {
		return DrelStandingbook.class;
	}
	
	/**
	 *  台账表导出查询
	 * @param domicileCode
	 */
	public DataSet queryInfo(ParameterSet pset) {
		String domicileCode = (String)pset.getParameter("domicileCode");
		String assistanceType = (String)pset.getParameter("assistanceType");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		
 		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT CNR, "); //成年人
		sql.append(" WCN , "); //未成年人
		sql.append(" ( nvl(assistance_money,0) + nvl(month_income,0) + nvl(low_standards,0) + nvl(otherMoney,0) + nvl(assistance_class_money,0) ) total_num , "); //合计
		sql.append("domicile_code,begin_date,card_no,family_name,family_card_no, sex,nation,address,family_postcode," +
				"family_phone,assistance_type,assistance_people_num,women_no,disability_no,isThreeNo,old_no," +
				" incumbency_no,flexible_no,unemployed_no, not_unemployed_no, student_no,other_no," +
				"assistance_money,month_income,low_standards,otherMoney,assistance_class_money,bank,account_number," +
				"change_type,change_date,is_enjoy,p1_name,p1_id_card,p2_name,p2_id_card,p3_name,P3_id_card,p4_name," +
				"p4_id_card,p5_name,p5_id_card,p6_name,p6_id_card,p7_name,P7_id_card,p8_name,p8_id_card,p9_name," +
				"p9_id_card");
		sql.append(" from DREL_STANDINGBOOK where 1=1");
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append(" AND DOMICILE_CODE LIKE ? "); 
			if(domicileCode.indexOf("000")>-1){
		   		argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
		    }else {
		   		argsList.add(domicileCode+"%");
			}
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(assistanceType)){
			sql.append(" AND ASSISTANCE_TYPE = ? ");
	   		argsList.add(assistanceType);
	   		typeList.add(Types.VARCHAR);
		}
		sql.append(" order by DOMICILE_CODE ");
		DataSet ds = new DataSet();
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} 
		return ds;
	}
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
}