package com.inspur.cams.drel.esurey.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFamilyDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFamily;

/**
 * @title:SamEsureyFamilyDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
 */
public class SamEsureyFamilyDao extends EntityDao<SamEsureyFamily> implements
		ISamEsureyFamilyDao {

	public SamEsureyFamilyDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamEsureyFamily.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SamEsureyFamily");
	}

	public void delete(String familyId) {
		String sql = "delete from SAM_ESUREY_FAMILY  WHERE  FAMILY_ID='"
				+ familyId + "'";
		executeUpdate(sql);
	}

	// 根据家庭ID数组查找家庭信息
	public DataSet queryByFamilyIds(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String[] familyIds = (String[]) pset.get("familyIds");
		sql.append("select * from sam_esurey_family \n");
		if (familyIds != null) {
			sql.append("where family_id='" + familyIds[0] + "' \n");
			for (int i = 1; i < familyIds.length; i++) {
				sql.append("or family_id='" + familyIds[i] + "' \n");
			}
		}
		return executeDataset(sql.toString(), pset.getPageStart(), pset
				.getPageLimit(), true);
	}

	public DataSet familySum(String familyId) {
		return null;
	}
   /**
    * 申报录入-提交操作
    * 
    * 
    */
	public void submit(String familyId, String checkOrgArea,String flag) {
		StringBuffer sql = new StringBuffer();
		if(flag.equals("0")){//市
			sql.append("UPDATE  SAM_ESUREY_FAMILY SET CUR_ACTIVITY='03',CUR_STATE='0',CHECK_ORG_AREA=? WHERE FAMILY_ID=?");
		}else if(flag.equals("1")){//区县
			sql.append("UPDATE  SAM_ESUREY_FAMILY SET CUR_ACTIVITY='02',CUR_STATE='0',CHECK_ORG_AREA=? WHERE FAMILY_ID=?");
		}
		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR, Types.VARCHAR },
				new Object[] {checkOrgArea,familyId });
	}

	/**
	 * 更新家庭中相关的户主信息
	 */

	public void updateNameOrIdCard(ParameterSet pset) {
		String familyId = (String) pset.getParameter("familyId");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String domicileType = (String) pset.getParameter("domicileType");
		StringBuffer sql = new StringBuffer();
		sql.append("update SAM_ESUREY_FAMILY SET FAMILY_NAME='");
		sql.append(name + "',");
		sql.append("FAMILY_CARD_NO='");
		sql.append(idCard + "',");
		sql.append("DOMICILE_TYPE='");
		sql.append(domicileType + "' ");
		sql.append("where FAMILY_ID='");
		sql.append(familyId + "'");
		executeUpdate(sql.toString());
	}

	/**
	 * 核对详情查询统计
	 */
	public DataSet queryStatistics(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT e.FAMILY_ID FAMILY_ID,e.FAMILY_TYPE FAMILY_TYPE,e.FAMILY_NAME FAMILY_NAME,e.FAMILY_CARD_NO FAMILY_CARD_NO,e.PEOPLE_NUM PEOPLE_NUM,");
		sql.append("GET_CITYNAME(e.REG_ADDRESS) REG_ADDRESS,GET_CITYNAME(e.FAMILY_ADDRESS) FAMILY_ADDRESS,e.ADDRESS ADDRESS,e.FAMILY_POSTCODE FAMILY_POSTCODE,e.DOMICILE_TYPE DOMICILE_TYPE,t.name DOMICILE_TYPE_NAME, e.CHECK_TIME CHECK_TIME,");
		sql.append("e.ASSISTANCE_TYPE ASSISTANCE_TYPE,u.name ASSISTANCE_TYPE_NAME,to_char(round(e.YEAR_INCOME,2),'FM99,999,999,990.00') YEAR_INCOME,to_char(round(e.YEAR_AVERAGE_INCOME,2),'FM99,999,999,990.00') YEAR_AVERAGE_INCOME,to_char(round(e.MONTH_INCOME,2),'FM99,999,999,990.00') MONTH_INCOME,to_char(round(e.MONTH_AVERAGE_INCOME,2),'FM99,999,999,990.00') MONTH_AVERAGE_INCOME,");
		sql.append("e.CUR_ACTIVITY CUR_ACTIVITY,e.CUR_STATE CUR_STATE,s.CREDIT_RATING CREDIT_RATING,d.name CREDIT_RATING_NAME,to_char(round(s.YEAR_INCOME,2),'FM99,999,999,990.00') SUM_YEAR_INCOME,to_char(round(s.YEAR_AVERAGE_INCOME,2),'FM99,999,999,990.00') SUM_YEAR_AVERAGE_INCOME,");
		sql.append("to_char(round(s.MONTH_INCOME,2),'FM99,999,999,990.00') SUM_MONTH_INCOME,to_char(round(s.MONTH_AVERAGE_INCOME,2),'FM99,999,999,990.00') SUM_MONTH_AVERAGE_INCOME from SAM_ESUREY_FAMILY_SUM s left join SAM_ESUREY_FAMILY e  ");
		sql.append(" on  e.FAMILY_ID=s.FAMILY_ID  left join dic_details t on e.DOMICILE_TYPE = t.code  left join dic_details u on e.ASSISTANCE_TYPE = u.code left join dic_details d on s.CREDIT_RATING = d.code   where  e.CUR_ACTIVITY='03' AND e.CUR_STATE='3' and t.dic_type = 'ESUREY_FAMILY_TYPE' and u.dic_type='ESUREY_ASSISTANCE_TYPE' and d.dic_type='ESUREY_CREDIT_RATING'  ");
		// 行政区划
		String familyAddress = (String) pset.getParameter("familyAddress");
		// 户主姓名
		String familyName = (String) pset.getParameter("familyName");
		// 户主身份证号码
		String familyCardNo = (String) pset.getParameter("familyCardNo");
		// 救助类型
		String assistanceType = (String) pset.getParameter("assistanceType");
		// 家庭性质
		String domicileType = (String) pset.getParameter("domicileType");
		// 家庭诚信等级
		String creditRating = (String) pset.getParameter("creditRating");
		// 汇总审核时间段
		String checkTimeBegin = (String) pset.getParameter("checkTimeBegin");
		String checkTimeEnd = (String) pset.getParameter("checkTimeEnd");
		String organArea = (String) pset.getParameter("organArea");
		if (StringUtils.isNotEmpty(familyName)) {
			sql.append("AND e.FAMILY_NAME=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(familyName);
		}
		if (StringUtils.isNotEmpty(familyCardNo)) {
			sql.append("AND e.FAMILY_CARD_NO=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(familyCardNo);
		}
		if (StringUtils.isNotEmpty(assistanceType)) {
			sql.append("AND e.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(assistanceType);
		}
		if (StringUtils.isNotEmpty(domicileType)) {
			sql.append("AND e.DOMICILE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(domicileType);
		}
		if (StringUtils.isNotEmpty(creditRating)) {
			sql.append("AND s.CREDIT_RATING=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(creditRating);
		}
		if (StringUtils.isNotEmpty(checkTimeBegin)) {
			sql.append("AND e.CHECK_TIME>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkTimeBegin);
		}
		if (StringUtils.isNotEmpty(checkTimeEnd)) {
			sql.append("AND e.CHECK_TIME<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkTimeEnd);
		}
		if (StringUtils.isNotEmpty(familyAddress)) {
			if (familyAddress.substring(4, 12).equals("00000000")) {
				String subFamilyAddress = familyAddress.substring(0, 4);
				sql.append("AND substr(e.FAMILY_ADDRESS,1,4)=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(subFamilyAddress);
			} else if (familyAddress.substring(6, 12).equals("000000")) {
				String subFamilyAddress = familyAddress.substring(0, 6);
				sql.append("AND substr(e.FAMILY_ADDRESS,1,6)=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(subFamilyAddress);
			} else if (familyAddress.substring(9, 12).equals("000")) {
				String subFamilyAddress = familyAddress.substring(0, 9);
				sql.append("AND substr(e.FAMILY_ADDRESS,1,9)=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(subFamilyAddress);
			} else {
				sql.append("AND e.FAMILY_ADDRESS =? ");
				typeList.add(Types.VARCHAR);
				objsList.add(familyAddress);
			}

		}
		if (StringUtils.isNotEmpty(organArea)) {
			if (organArea.substring(4, 12).equals("00000000")) {
				String subOrganArea = organArea.substring(0, 4);
				sql.append(" AND substr(e.FAMILY_ADDRESS,1,4)=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(subOrganArea);
			} else if (organArea.substring(6, 12).equals("000000")) {
				String subOrganArea = organArea.substring(0, 6);
				sql.append(" AND substr(e.FAMILY_ADDRESS,1,6)=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(subOrganArea);
			}
		}
		 sql.append(" ORDER BY e.CHECK_TIME desc");
		DataSet ds=new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(),getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
	}
	
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
		private int getDsLimit(ParameterSet pset) {
			String excelType = (String)pset.getParameter("excelType");
			if(null==excelType||"0,1".indexOf(excelType)==-1) {
				return pset.getPageLimit();
			}
			int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
			return limit>1000?1000:limit;
		}
	/**
	 * 收入或财产统计
	 */
	public DataSet queryIncomeWorth(ParameterSet pset) {
		String familyAddress = (String) pset.getParameter("familyAddress");
		String assistanceType = (String) pset.getParameter("assistanceType");
		String domicleType = (String) pset.getParameter("domicleType");
		String dateBegin = (String) pset.getParameter("dateBegin");
		String dateEnd = (String) pset.getParameter("dateEnd");
		String incomeBegin = (String) pset.getParameter("incomeBegin");
		String incomeEnd = (String) pset.getParameter("incomeEnd");
		String esureyBegin = (String) pset.getParameter("esureyBegin");
		String esureyEnd = (String) pset.getParameter("esureyEnd");
		String organArea = (String) pset.getParameter("organArea");
		StringBuffer sql = new StringBuffer("select t1.applyNum APPLY_NUM, ");
		sql.append("GET_CITYNAME(t1.family_address) FAMILY_ADDRESS, ");
		sql.append("t1.assistance_type ASSISTANCE_TYPE, ");
		sql.append("t1.domicile_type DOMICILE_TYPE, ");
		sql.append("decode(t1.checkNum,null,'0',t1.checkNum) CHECK_NUM, ");
		sql
				.append("decode(t2.incomeNum,null,'0.00',to_char(round(t2.incomeNum,2),'FM99,999,999,990.00')) INCOME_NUM, ");
		sql
				.append("decode(t2.worthNum,null,'0.00',to_char(round(t2.worthNum,2),'FM99,999,999,990.00')) WORTH_NUM, ");
		sql.append("t3.qWorthInNum QWORTHIN_NUM, ");
		sql
				.append("decode(t1.checkNum,null,'0.00','0','0.00',to_number(to_char(round(t3.qWorthInNum / t1.checkNum,2),'FM99,999,999,990.00')))*100||'%' WORTHIN_RATE  ");
		sql.append("from ((select ");
		sql.append(familyAddress + " family_address,");
		sql.append(assistanceType + " assistance_type,");
		sql.append(domicleType + " domicile_type,");
		sql.append("count(family_id) applyNum,"
				+ "sum(case when CUR_ACTIVITY = '03' and CUR_STATE = '3'");
		sql.append(" and ASSISTANCE_TYPE='" + assistanceType + "' ");
		if (StringUtils.isNotEmpty(familyAddress)) {
			if (familyAddress.substring(4, 12).equals("00000000")) {
				String subFamilyAddress = familyAddress.substring(0, 4);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else if (familyAddress.substring(6, 12).equals("000000")) {
				String subFamilyAddress = familyAddress.substring(0, 6);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else if (familyAddress.substring(9, 12).equals("000")) {
				String subFamilyAddress = familyAddress.substring(0, 9);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else {
				sql.append("AND FAMILY_ADDRESS ='" + familyAddress + "' ");
			}

		}
		sql.append(" and DOMICILE_TYPE='" + domicleType + "' ");
		if (StringUtils.isNotEmpty(dateBegin)) {
			sql.append(" AND CHECK_TIME>='" + dateBegin + "' ");
		}
		if (StringUtils.isNotEmpty(dateEnd)) {
			sql.append(" AND CHECK_TIME<='" + dateEnd + "' ");
		}
		sql.append("then 1 else 0 end) checkNum ");
		sql.append(" from sam_esurey_family a " + "where family_type = 'K' ");
		sql.append(" and assistance_type='" + assistanceType + "' ");
		if (StringUtils.isNotEmpty(familyAddress)) {
			if (familyAddress.substring(4, 12).equals("00000000")) {
				String subFamilyAddress = familyAddress.substring(0, 4);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else if (familyAddress.substring(6, 12).equals("000000")) {
				String subFamilyAddress = familyAddress.substring(0, 6);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else if (familyAddress.substring(9, 12).equals("000")) {
				String subFamilyAddress = familyAddress.substring(0, 9);
				sql.append("AND FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ");
			} else {
				sql.append("AND FAMILY_ADDRESS ='" + familyAddress + "' ");
			}
		}
		sql.append(" and assistance_type='" + assistanceType + "' ");
		if (StringUtils.isNotEmpty(dateBegin)) {
			sql.append("AND CHECK_TIME>='" + dateBegin + "' ");
		}
		if (StringUtils.isNotEmpty(dateEnd)) {
			sql.append("AND CHECK_TIME<='" + dateEnd + "' ");
		}
		sql.append(" and domicile_type='" + domicleType + "')) t1,");
		sql
				.append("(select avg(s.YEAR_INCOME) incomeNum, avg(s.FAMILY_WORTH) worthNum "
						+ " from sam_esurey_family_sum s,sam_esurey_family e where s.family_id=e.family_id  ");
		if (StringUtils.isNotEmpty(incomeBegin)) {
			sql.append(" and s.YEAR_INCOME >='" + incomeBegin + "'");
		}
		if (StringUtils.isNotEmpty(incomeEnd)) {
			sql.append(" and s.YEAR_INCOME <= '");
			sql.append(incomeEnd + "'");
		}
		if (StringUtils.isNotEmpty(esureyBegin)) {
			sql.append(" and s.FAMILY_WORTH >= '" + esureyBegin + "' ");
		}
		if (StringUtils.isNotEmpty(esureyEnd)) {
			sql.append(" and s.FAMILY_WORTH <= '" + esureyEnd + "'");
		}
		sql.append(" and e.assistance_type='" + assistanceType + "' ");
		sql.append(" and e.domicile_type='" + domicleType + "' ");
		if (StringUtils.isNotEmpty(dateBegin)) {
			sql.append("AND e.CHECK_TIME>='" + dateBegin + "' ");
		}
		if (StringUtils.isNotEmpty(dateEnd)) {
			sql.append("AND e.CHECK_TIME<='" + dateEnd + "' ");
		}
		if (StringUtils.isNotEmpty(familyAddress)) {
			if (familyAddress.substring(4, 12).equals("00000000")) {
				String subFamilyAddress = familyAddress.substring(0, 4);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%') t2, ");
			} else if (familyAddress.substring(6, 12).equals("000000")) {
				String subFamilyAddress = familyAddress.substring(0, 6);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%') t2, ");
			} else if (familyAddress.substring(9, 12).equals("000")) {
				String subFamilyAddress = familyAddress.substring(0, 9);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ) t2,");
			} else {
				sql.append(" AND e.FAMILY_ADDRESS ='" + familyAddress
						+ "' ) t2,");
			}

		}
		sql
				.append(" (select count(s.family_id) qWorthInNum "
						+ " from sam_esurey_family_sum s ,sam_esurey_family e where s.family_id=e.family_id  ");
		if (StringUtils.isNotEmpty(incomeBegin)) {
			sql.append(" and s.YEAR_INCOME >='" + incomeBegin + "'");
		}
		if (StringUtils.isNotEmpty(incomeEnd)) {
			sql.append(" and s.YEAR_INCOME <= '");
			sql.append(incomeEnd + "'");
		}
		if (StringUtils.isNotEmpty(esureyBegin)) {
			sql.append(" and s.FAMILY_WORTH >= '" + esureyBegin + "' ");
		}
		if (StringUtils.isNotEmpty(esureyEnd)) {
			sql.append(" and s.FAMILY_WORTH <= '" + esureyEnd + "'");
		}
		sql.append(" and e.assistance_type='" + assistanceType + "' ");
		sql.append(" and e.domicile_type='" + domicleType + "' ");
		if (StringUtils.isNotEmpty(dateBegin)) {
			sql.append("AND e.CHECK_TIME>='" + dateBegin + "' ");
		}
		if (StringUtils.isNotEmpty(dateEnd)) {
			sql.append("AND e.CHECK_TIME<='" + dateEnd + "' ");
		}
		if (StringUtils.isNotEmpty(familyAddress)) {
			if (familyAddress.substring(4, 12).equals("00000000")) {
				String subFamilyAddress = familyAddress.substring(0, 4);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%') t3 ");
			} else if (familyAddress.substring(6, 12).equals("000000")) {
				String subFamilyAddress = familyAddress.substring(0, 6);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%') t3 ");
			} else if (familyAddress.substring(9, 12).equals("000")) {
				String subFamilyAddress = familyAddress.substring(0, 9);
				sql.append(" AND e.FAMILY_ADDRESS like '" + subFamilyAddress
						+ "%' ) t3");
			} else {
				sql.append(" AND e.FAMILY_ADDRESS ='" + familyAddress
						+ "' ) t3");
			}
		}
		if (StringUtils.isNotEmpty(organArea)) {
			String oa = organArea.substring(0, organArea.indexOf("000"));
			sql.append(" where FAMILY_ADDRESS like '" + oa + "%'");
		}
		if (!StringUtils.isNotEmpty(familyAddress)) {
			return null;
		} else {
			return executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
	}

	/**
	 * 诚信统计
	 */
	public DataSet queryCredit(ParameterSet pset) {
		String creditRating = (String) pset.getParameter("creditRating");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String assistanceType = (String) pset.getParameter("assistanceType");
		String familyAddress = (String) pset.getParameter("familyAddress");
		String organArea = (String) pset.getParameter("organArea");
		StringBuffer sql = new StringBuffer("SELECT "
				+ "GET_CITYNAME(f.FAMILY_ADDRESS)  FAMILY_ADDRESS,"
				+ "COUNT(s.CREDIT_RATING) AS GN, " + "s.CREDIT_RATING  "
				+ "FROM "
				+ "SAM_ESUREY_FAMILY_SUM s LEFT JOIN SAM_ESUREY_FAMILY f "
				+ "ON f.FAMILY_ID=s.FAMILY_ID " + "WHERE 1=1 ");

		if (StringUtils.isNotEmpty(creditRating)) {
			sql.append(" AND s.CREDIT_RATING='" + creditRating + "' ");
		}
		if (StringUtils.isNotEmpty(startTime)) {
			sql.append(" AND f.REG_TIME>='" + startTime + "' ");
		}
		if (StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND f.REG_TIME<='" + endTime + "'");
		}
		if (StringUtils.isNotEmpty(assistanceType)) {
			sql.append(" AND f.ASSISTANCE_TYPE='" + assistanceType + "' ");
		}
		if (StringUtils.isNotEmpty(familyAddress)) {
			sql.append(" AND f.FAMILY_ADDRESS like '"
					+ familyAddress.substring(0, 6) + "%' ");
		}
		if (StringUtils.isNotEmpty(organArea)) {
			sql.append(" AND f.FAMILY_ADDRESS like '" + organArea + "%' ");
		}
		sql.append("GROUP BY f.FAMILY_ADDRESS ,s.CREDIT_RATING");
		return super.executeDataset(sql.toString(), pset.getPageStart(), pset
				.getPageLimit(), true);
	}

	/**
	 * 查询是否存在相应的信息
	 */
	public BigDecimal beExistMess(String idCard){
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT SUM(NUM) NUM FROM (");
		sql.append("SELECT COUNT(*) NUM FROM BASEINFO_FAMILY  WHERE FAMILY_CARD_NO='");
		sql.append(idCard).append("'  ");
		sql.append("union ");
		sql.append("SELECT COUNT(*) NUM FROM SAM_ESUREY_FAMILY  WHERE FAMILY_CARD_NO='");
		sql.append(idCard).append("' )");
		List<Map<String,BigDecimal>> list=executeQuery(sql.toString());
		BigDecimal num=list.get(0).get("NUM");
		return num;
	}
	/**
	 * 
	 * 2-区县经济核对中心上报核对任务到市经济核对中心
	 */
	public void centerSubmit(String familyId, String checkOrgArea,String flag) {
		StringBuffer sql = new StringBuffer();
		if(flag.equals("0")){
			sql.append("UPDATE  SAM_ESUREY_FAMILY SET CUR_ACTIVITY='03',CUR_STATE='0',CHECK_ORG_AREA=? WHERE FAMILY_ID=?");
		}else if(flag.equals("1")){
			sql.append("UPDATE  SAM_ESUREY_FAMILY SET CUR_ACTIVITY='01',CUR_STATE='1',CHECK_ORG_AREA=? WHERE FAMILY_ID=?");
		}
		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR, Types.VARCHAR },
				new Object[] {checkOrgArea,familyId });
	}
	
}
