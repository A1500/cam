package com.inspur.cams.drel.sam.dao.jdbc;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.BspUtil;
/**
 * 困難戶家庭信息查詢
 * @author Jiangzhaobao
 *
 * @date 2011-6-27
 */
public class FamilyQueryDao extends BaseJdbcDao {

	@Override
	protected void initDao() {

	}
	/**
	 * 困难户家庭信息查询
	 * @param params
	 * @return
	 */
	public DataSet query(ParameterSet params) {
		StringBuffer jtxxSql = new StringBuffer();

		jtxxSql.append(" SELECT BASEINFO_FAMILY.FAMILY_ID as FAMILY_ID,BASEINFO_FAMILY.FAMILY_NAME AS FAMILY_NAME,BASEINFO_FAMILY.FAMILY_CARD_NO AS FAMILY_CARD_NO,BASEINFO_FAMILY.PEOPLE_NUM AS PEOPLE_NUM,PHOTO_ID, ");
		jtxxSql.append(" BASEINFO_FAMILY.YEAR_INCOME AS YEAR_INCOME,BASEINFO_FAMILY.CUR_ACTIVITY AS CUR_ACTIVITY ,BASEINFO_FAMILY.CHECK_FLAG AS CHECK_FLAG,BASEINFO_FAMILY.REG_PEOPLE AS REG_PEOPLE, ");
		jtxxSql.append(" BASEINFO_FAMILY.REG_ORG_NAME AS REG_ORG_NAME,BASEINFO_FAMILY.REG_TIME AS REG_TIME  from BASEINFO_FAMILY  where 1=1 ");
		//当前登陆人单位区划
		//BspUtil.getDeptOrgan().getOrganCode()
		String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		String familyName = (String) params.getParameter("FAMILY_NAME");//户主姓名
		String familyCardNo = (String) params.getParameter("FAMILY_CARD_NO");//身份证号
		String regOrg = (String) params.getParameter("REG_ORG");//录入单位ID
		String assistanceType = (String) params.getParameter("ASSISTANCE_TYPE");//救助类型代码
		String regTimes = (String) params.getParameter("REG_TIMES");//录入起始时间
		String regTimet = (String) params.getParameter("REG_TIMET");//录入结束时间

		//查询条件
		if (familyName != null && !familyName.equals("")) {//戶主姓名
			jtxxSql.append(" AND BASEINFO_FAMILY.FAMILY_NAME= '").append(familyName).append("'");
		}
		if (familyCardNo != null && !familyCardNo.equals("")) {//戶主身份證
			jtxxSql.append(" AND BASEINFO_FAMILY.FAMILY_CARD_NO= '").append(familyCardNo).append("'");
		}
		if (regOrg != null && !regOrg.equals("")) {//所屬單位
			jtxxSql.append(" AND BASEINFO_FAMILY.REG_ORG='").append(regOrg).append("'");
		}
		if (assistanceType != null && !assistanceType.equals("")) {//救助類型
//			jtxxSql.append(" AND BASEINFO_FAMILY.ASSISTANCE_TYPE<='").append(assistanceType).append("'");
			jtxxSql.append(" and BASEINFO_FAMILY.family_id in (select distinct (b.family_id) from SAM_FAMILY_ASSISTANCE b where b.ASSISTANCE_TYPE ='").append(assistanceType).append("')");
		}
		if (regTimes != null && !regTimes.equals("")) {
			jtxxSql.append(" AND BASEINFO_FAMILY.REG_TIME>='").append(regTimes).append("'");
		}
		if (regTimet != null && !regTimet.equals("")) {
			jtxxSql.append(" AND BASEINFO_FAMILY.REG_TIME<='").append(regTimet).append("'");
		}

		//数据权限设置（上级能查看下级信息，下级不能查看上级信息）
	    String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
		   createOrgan=organCode.substring(0,2);
		 }else if(organCode.substring(4,12).equals("00000000")){
		   createOrgan=organCode.substring(0,4);
		 }else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
	       createOrgan=organCode.substring(0,6);
		 }else if(organCode.substring(9,12).equals("000")){
		   createOrgan=organCode.substring(0,9);
		 }else  {
		  createOrgan=organCode;
		 }
	    jtxxSql.append(" AND BASEINFO_FAMILY.REG_ORG_AREA LIKE '").append(createOrgan).append("%'");
		jtxxSql.append(" ORDER BY  BASEINFO_FAMILY.REG_ORG_NAME");
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		return executeDataset(jtxxSql.toString(), start, limit, true);
	}

}
