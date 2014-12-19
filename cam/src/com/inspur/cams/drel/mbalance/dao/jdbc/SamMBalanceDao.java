package com.inspur.cams.drel.mbalance.dao.jdbc;

import java.sql.Types;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.mbalance.dao.ISamMBalanceDao;
import com.inspur.cams.drel.mbalance.data.SamMBalance;


/**
 * @title:SamMedicalBalanceDao
 * @description:一站式救助Dao实现
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public class SamMBalanceDao extends EntityDao<SamMBalance> implements ISamMBalanceDao{

 	public SamMBalanceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamMBalance.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamMedicalBalance");
	}
	/**
	 * 用于住院登记信息列表页面数据查询
	 */
	public DataSet queryForSamList(ParameterSet paramSet) {
		StringBuffer sql = new StringBuffer();
		sql.append("select  a.*,CNMONEY(a.ASSITANCE_PAY) ASSITANCE_PAYCH,CNMONEY(a.SPECIAL_PAY) SPECIAL_PAYCN ,CNMONEY(a.PERSONAL_PAY) PERSONAL_PAYCN   \n");
		sql.append("  from sam_medical_balance a \n");
		sql.append(" where 1 = 1           \n");
	
		String disease =(String) paramSet.getParameter("disease");
		if(StringUtils.isNotEmpty(disease)){
			sql.append(" and a.disease='" + disease + "'");
		}
		String strikeStatus =(String) paramSet.getParameter("strikeStatus");
		if(StringUtils.isNotEmpty(strikeStatus)){
			sql.append(" and a.strike_Status in ("+strikeStatus+") ");
		}
		String balanceId =(String) paramSet.getParameter("balanceId");
		if(StringUtils.isNotEmpty(balanceId)){
			sql.append(" and a.balance_Id='" + balanceId + "'");
		}
		String insuranceType =(String) paramSet.getParameter("insuranceType");
		if(StringUtils.isNotEmpty(insuranceType)){
			sql.append(" and a.insurance_Type='" + insuranceType + "'");
		}
		String assitanceType =(String) paramSet.getParameter("assitanceType");
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" and a.assitance_Type='" + assitanceType + "'");
		}
		String beginTime =(String) paramSet.getParameter("beginTime");
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" and a.balance_Time>='" + beginTime + "'");
		}
		String endTime =(String) paramSet.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" and a.balance_Time<='" + endTime + "'");
		}
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append(" and a.DOMICILE_CODE like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
		}
		String sex =(String) paramSet.getParameter("sex");
		if(StringUtils.isNotEmpty(sex)){
			sql.append(" and a.sex='" + sex + "'");
		}
		String leaveTime =(String) paramSet.getParameter("leaveTime");
		if(StringUtils.isNotEmpty(leaveTime)){
			sql.append(" and a.balance_Time<='" + leaveTime + "'");
		}
		String familyId =(String) paramSet.getParameter("familyId");
		if(StringUtils.isNotEmpty(familyId)){
			sql.append(" and a.family_id='" + familyId + "'");
		}
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" and a.hospital_Id='" + hospitalId + "'");
		}
		String peopleId =(String) paramSet.getParameter("peopleId");
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" and a.people_Id='" + peopleId + "'");
		}
		String leaveDate =(String) paramSet.getParameter("leaveDate");
		if(StringUtils.isNotEmpty(leaveDate)){
			sql.append(" and a.leave_date like '" + leaveDate + "'");
		}
		String hospitalRecordId =(String) paramSet.getParameter("hospitalRecordId");
		if(StringUtils.isNotEmpty(hospitalRecordId)){
			sql.append(" and a.hospital_Record_Id='" + hospitalRecordId + "'");
		}
		String inTime =(String) paramSet.getParameter("inTime");
		if(StringUtils.isNotEmpty(inTime)){
			sql.append(" and a.in_Date='" + inTime + "'");
		}
		String historyYear =(String) paramSet.getParameter("historyYear");
		if(StringUtils.isNotEmpty(historyYear)){
			sql.append(" and a.balance_Time like '" + historyYear + "%'");
		}
		String dataSource =(String) paramSet.getParameter("dataSource");
		if(StringUtils.isNotEmpty(dataSource)){
			sql.append(" and a.DATA_SOURCE = '" + dataSource + "'");
		}
		String regId =(String) paramSet.getParameter("regId");
		if(StringUtils.isNotEmpty(regId)){
			sql.append(" and a.REG_ID = '" + regId + "'");
		}
		String idCard =(String) paramSet.getParameter("idCard");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" and a.ID_CARD = '" + idCard + "'");
		}
		String hosStatus =(String) paramSet.getParameter("hosStatus");
		if("0".equals(hosStatus)){
			sql.append("and a.status = '2' \n");
			sql.append("order by in_Date desc");
		}else if("1".equals(hosStatus)){
			sql.append("and a.status in ('0','1') \n");
			sql.append("order by in_Date desc");
		}
		DataSet ds= executeDataset(sql.toString(),getDsStart(paramSet),getDsLimit(paramSet),true);
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
	 * 一站式结算报表统计查询
	 * @return
	 */
	public DataSet queryForReportDetail(ParameterSet paramSet) {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.*                \n");
		sql.append("  from sam_medical_balance a \n");
		sql.append(" where 1 = 1            \n");
	
		String disease =(String) paramSet.getParameter("disease");
		if(StringUtils.isNotEmpty(disease)){
			sql.append(" and a.disease='" + disease + "'");
		}
		String insuranceType =(String) paramSet.getParameter("insuranceType");
		if(StringUtils.isNotEmpty(insuranceType)){
			sql.append(" and a.insurance_Type='" + insuranceType + "'");
		}
		String assitanceType =(String) paramSet.getParameter("assitanceType");
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" and a.assitance_Type='" + assitanceType + "'");
		}
		String beginTime =(String) paramSet.getParameter("beginTime");
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" and a.balance_Time>='" + beginTime + "'");
		}
		String endTime =(String) paramSet.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" and a.balance_Time<='" + endTime + "'");
		}
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append(" and a.DOMICILE_CODE like '" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
		}
		String sex =(String) paramSet.getParameter("sex");
		if(StringUtils.isNotEmpty(sex)){
			sql.append(" and a.sex='" + sex + "'");
		}
		String leaveTime =(String) paramSet.getParameter("leaveTime");
		if(StringUtils.isNotEmpty(leaveTime)){
			sql.append(" and a.balance_Time<='" + leaveTime + "'");
		}
		String familyId =(String) paramSet.getParameter("familyId");
		if(StringUtils.isNotEmpty(familyId)){
			sql.append(" and a.family_id='" + familyId + "'");
		}
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" and a.hospital_Id='" + hospitalId + "'");
		}
		String peopleId =(String) paramSet.getParameter("peopleId");
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" and a.people_Id='" + peopleId + "'");
		}
		String hospitalRecordId =(String) paramSet.getParameter("hospitalRecordId");
		if(StringUtils.isNotEmpty(hospitalRecordId)){
			sql.append(" and a.hospital_Record_Id='" + hospitalRecordId + "'");
		}
		String inTime =(String) paramSet.getParameter("inTime");
		if(StringUtils.isNotEmpty(inTime)){
			sql.append(" and a.in_Date='" + inTime + "'");
		}
		String historyYear =(String) paramSet.getParameter("historyYear");
		if(StringUtils.isNotEmpty(historyYear)){
			sql.append(" and a.balance_Time like'" + historyYear + "%'");
		}
		String hosStatus =(String) paramSet.getParameter("hosStatus");
		if("0".equals(hosStatus)){
			sql.append("and a.balance_Time is not null");
		}else if("1".equals(hosStatus)){
			sql.append("and a.balance_Time is  null");
		}else{
			sql.append("and a.balance_Time is not null");
		}
		DataSet ds= executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(), true);
		return ds;
	}
   /**
    * 根据人员ID查询人员未出院人员信息，用于住院登记校验
    * @param paramSet
    * @return
    */
   public DataSet queryForInCheck(ParameterSet paramSet){
	   	StringBuffer sql = new StringBuffer();
		String peopleId =(String) paramSet.getParameter("peopleId");
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append("select *               \n");
			sql.append("  from sam_medical_balance  \n");
			sql.append(" where status = '1'   \n");
			sql.append(" and people_Id='" + peopleId + "'");
			return executeDataset(sql.toString(), true);
		}
		return null;
   }

   /**
    * 查询历史救助费用
    */
	public DataSet queryForBalanceHistory(ParameterSet paramSet) {
		StringBuffer sql=new StringBuffer();
		sql.append("select  nvl(sum(assitance_Pay),0) yearAssistance   \n");
		sql.append(" from  sam_medical_balance                  \n");
		sql.append(" where status = '2'            \n");
		String peopleId =(String) paramSet.getParameter("peopleId");
		if(StringUtils.isNotEmpty(StringUtils.trim(peopleId))){
			sql.append("and people_Id='"+peopleId+"' \n");
			sql.append("and balance_Time like '"+DateUtil.getYear()+"%'");
			return executeDataset(sql.toString(), true);
			
		}
		return null;
	}
	
	
	public DataSet queryBalance(String peopleId,String inDate){
		StringBuffer sql=new StringBuffer();
		sql.append(" select * from sam_medical_balance  \n");
		sql.append(" where  STRIKE_STATUS = '00' \n");
		sql.append(" and  people_Id='"+peopleId+"' ");
		sql.append(" and  in_date='"+inDate+"' ");
		sql.append(" order by reg_time desc ");
		return executeDataset(sql.toString(), true);
	}
	
	public DataSet queryBalance(String status,String peopleId,String inDate,String hospitalId,String strikeStatus){
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {status,peopleId,inDate,hospitalId,strikeStatus};
		StringBuffer sql=new StringBuffer();
		sql.append(" select * from sam_medical_balance  \n");
		sql.append(" where  status = ? \n");
		sql.append(" and  people_Id= ? \n");
		sql.append(" and  in_date= ? \n");
		sql.append(" and  hospital_id= ? \n");
		sql.append(" and  strike_status= ? \n");
		sql.append(" order by reg_time desc \n");
		return executeDataset(sql.toString(), types, objs, true);
	}
	/**
	 * 停助方法
	 */
	public void stopAssistance(ParameterSet paramSet) {
		StringBuffer sql=new StringBuffer();
		sql.append("update sam_medical_balance \n");
		String status=(String)paramSet.get("status");
		sql.append(" set status='"+status+"' \n");
		String balanceId=(String)paramSet.get("balanceId");
		sql.append("where balance_Id='"+balanceId+"'\n");
		executeUpdate(sql.toString());
	}
	/**
	 * 一站式结算报表统计查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForReport(ParameterSet paramSet) {
		StringBuffer sql=new StringBuffer();
		sql.append("select to_char(round(sum(TOTAL_EXPENSE),2),'FM99,999,999,990.00')as  sumTotalExp,");
		sql.append("to_char(round(sum(INSURANCE_EXPENSE),2),'FM99,999,999,990.00')as  sumInsExp,");
		sql.append("to_char(round(sum(INSURANCE_PAY),2),'FM99,999,999,990.00')as  sumInsPay,");
		sql.append("to_char(round(sum(ASSITANCE_PAY),2),'FM99,999,999,990.00')as  sumAssPay,");
		sql.append("to_char(round(sum(PERSONAL_PAY),2) ,'FM99,999,999,990.00')as sumPersonalPay,");
		sql.append("to_char(round(sum(HOSPITAL_PAY),2) ,'FM99,999,999,990.00')as HOSPITAL_PAY,");				//统计商业保险
		sql.append("to_char(round(sum(ILLNESS_INSURANCE_PAY),2) ,'FM99,999,999,990.00')as ILLNESS_INSURANCE_PAY,");				//统计医院减免
		sql.append("count(*) num,");
		sql.append("to_char(round(sum(ASSITANCE_PAY)/count(*),2),'FM99,999,999,990.00')as  assPerNum,");
		sql.append("to_char(round(sum(TOTAL_EXPENSE)/count(*),2),'FM99,999,999,990.00')as  totalExpPerNum,");
		sql.append("to_char(round(sum(PERSONAL_PAY)/count(*),2),'FM99,999,999,990.00')as  personalPayPerNum,");
		sql.append("to_char(round(sum(INSURANCE_EXPENSE)/count(*),2) ,'FM99,999,999,990.00')as insExpPerNum,");
		sql.append("to_char(round(sum(ASSITANCE_PAY)/sum(TOTAL_EXPENSE),2),'FM99,999,999,990.00')as  assPayPerTotalExp,");
		sql.append("to_char(round(sum(ASSITANCE_PAY)/(sum(INSURANCE_EXPENSE)-sum(INSURANCE_PAY)-sum(OTHER_PAY)),2),'FM99,999,999,990.00')as  personalPayPerBase  ");
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		String hospictalArea =(String) paramSet.getParameter("hospictalArea");
		String assitanceType =(String) paramSet.getParameter("assitanceType");
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		String currentJsp =(String) paramSet.getParameter("currentJsp");
		if("hos".equals(currentJsp)){
			sql.append(",hospital_id \n");
			sql.append("from sam_medical_balance \n");
			sql.append(" where status='2'            \n");
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append("  and hospital_Id='" + hospitalId + "' \n");
			}
			String regId =(String) paramSet.getParameter("regId");
			if(StringUtils.isNotEmpty(regId)){
				sql.append(" and REG_ID = '" + regId + "'");
			}
			if(StringUtils.isNotEmpty(hospictalArea)){
				sql.append(" and HOSPITAL_AREA like'" + getAreaCodeLikePrefix(hospictalArea) + "%' \n");
			}
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append(" and hospital_Area like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append(" and balance_Time>='" + beginTime + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append(" and balance_Time<='" + endTime + "' \n");
			}
			sql.append(" and assitance_Type is not null \n");
			sql.append(" group by hospital_id \n");
		}else if("ass".equals(currentJsp)){
			sql.append(" ,assitance_Type  \n");
			sql.append(" from sam_medical_balance a \n");
			sql.append(" where 1=1            \n");
			sql.append(" and   status='2'            \n");
			if(StringUtils.isNotEmpty(assitanceType)){
				sql.append(" and assitance_Type='" + assitanceType + "' \n");
			}
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append(" and hospital_Id='" + hospitalId + "' \n");
			}
			String regId =(String) paramSet.getParameter("regId");
			if(StringUtils.isNotEmpty(regId)){
				sql.append(" and a.REG_ID = '" + regId + "'");
			}
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append("and DOMICILE_CODE like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append("and balance_Time>='" + beginTime + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append("and balance_Time<='" + endTime + "' \n");
			}
			sql.append("and assitance_Type is not null \n");
			sql.append("group by assitance_Type \n");
		}else if("dom".equals(currentJsp)){
			int index=6;
			if(StringUtils.isNotEmpty(domicileCode)){
				if(domicileCode.indexOf("000")<6&&domicileCode.indexOf("000")>0){
					index=domicileCode.indexOf("000")+2;
				}
			}
			sql.append(", rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0') DOMICILE_CODE \n");
			sql.append("from sam_medical_balance a  \n");
			sql.append("where 1=1 \n");
			sql.append(" and status='2'            \n");
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append("and DOMICILE_CODE like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append("and hospital_Id='" + hospitalId + "' \n");
			}
			String regId =(String) paramSet.getParameter("regId");
			if(StringUtils.isNotEmpty(regId)){
				sql.append(" and a.REG_ID = '" + regId + "'");
			}
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append("and balance_Time>='" + beginTime + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append("and balance_Time<='" + endTime + "' \n");
			}
			sql.append("and assitance_Type is not null \n");
			sql.append("group by  rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0') \n");
		}else{
			sql.append("from sam_medical_balance \n");
		}
		return executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(), true);
	}
	
	/**
	 * 按救助对象属地、救助金额区间、时间段统计查询（柱状图展现）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForFlex(ParameterSet paramSet){
		StringBuffer sql=new StringBuffer();
		String minPay=(String)paramSet.getParameter("minPay");
		String maxPay=(String)paramSet.getParameter("maxPay");
		if(StringUtils.isNotEmpty(minPay)||StringUtils.isNotEmpty(maxPay)){
			sql.append("select * from (");	
		}
		sql.append("select sum(ASSITANCE_PAY) sumAssPay");
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		String hospictalArea =(String) paramSet.getParameter("hospictalArea");
		String assitanceType =(String) paramSet.getParameter("assitanceType");
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		String currentJsp =(String) paramSet.getParameter("currentJsp");
		if("dom".equals(currentJsp)){
			int index=6;
			if(StringUtils.isNotEmpty(domicileCode)){
				if(domicileCode.indexOf("000")<6&&domicileCode.indexOf("000")>0){
					index=domicileCode.indexOf("000")+2;
				}
			}
			if(domicileCode.indexOf("000")<6&&domicileCode.indexOf("000")>0){
				index=domicileCode.indexOf("000")+2;
			}
			sql.append(", rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0') DOMICILE_CODE \n");
			sql.append("from sam_medical_balance a   \n");
			sql.append("where 1=1 \n");
			sql.append(" and status='2'            \n");
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append("and DOMICILE_CODE like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append("and hospital_Id='" + hospitalId + "' \n");
			}
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append("and balance_Time>='" + beginTime + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append("and balance_Time<='" + endTime + "' \n");
			}
			sql.append("group by  rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0') \n");

			if(StringUtils.isNotEmpty(minPay)||StringUtils.isNotEmpty(maxPay)){
				sql.append(") a \n");	
				sql.append(" where 1=1 \n ");	
				if(StringUtils.isNotEmpty(maxPay)){
					sql.append("and a.sumAssPay<='" + maxPay + "' \n");
				}
				if(StringUtils.isNotEmpty(minPay)){
					sql.append("and a.sumAssPay>='" + minPay + "' \n");
				}
			}
		}else{
			sql.append("from sam_medical_balance \n");
		}
		return executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(), true);
	}
	/**
	 * 一站式结算报表统计查询-按照一定条件
	 * @param paramSet
	 * @return
	 */
	public DataSet querybuilderList(ParameterSet paramSet){
		StringBuffer sql = new StringBuffer();
		sql.append("select a.*                             \n");
		sql.append("  from sam_medical_balance a                             \n");
		sql.append(" where 1 = 1                                           \n");

		String hospitalId =(String) paramSet.getParameter("hospitalId");
		String organCode =(String) paramSet.getParameter("organCode");
		String assitanceType =(String) paramSet.getParameter("assitanceType");
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		String beginTime =(String) paramSet.getParameter("beginTime");
		String endTime = (String) paramSet.getParameter("endTime");
		//救助类型
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" and a.assitance_Type='" + assitanceType + "'");
			//当前登录单位
			if(StringUtils.isNotEmpty(organCode)){
				sql.append("and a.hospital_Area like'" + getAreaCodeLikePrefix(organCode) + "%' \n");
			}
		}
		String regId =(String) paramSet.getParameter("regId");
		if(StringUtils.isNotEmpty(regId)){
			sql.append(" and a.REG_ID = '" + regId + "'");
		}
		//救助对象所在地
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append("and a.domicile_Code like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
		//医院ID
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" and a.hospital_Id='" + hospitalId + "'");
		}
		//结算时间
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" and a.balance_Time>='" + beginTime + "'");
		}
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" and a.balance_Time<='" + endTime + "'");
		}
		sql.append(" and a.balance_Time is not null");
		sql.append(" and a.assitance_Type is not null");
		DataSet ds= executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(),true);
		return ds;
	}
	/**
	 * 按属地时间段救助金额查询
	 */
	public DataSet queryForDetailReport(ParameterSet paramSet){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT  GET_CITY_NAME( DOMICILE_CODE ) CITY_NAME,  \n");
		sql.append("      TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(E.BIRTHDAY, 0, 4)) AGE,   \n");
		sql.append("      E.*,(E.INSURANCE_EXPENSE-E.INSURANCE_PAY-E.HOSPITAL_PAY) BPT_BASE ,(E.INSURANCE_EXPENSE-E.INSURANCE_PAY-E.HOSPITAL_PAY-E.SPECIAL_PAY-E.OTHER_PAY) INSURANCE_BASE \n");
		sql.append("   FROM    \n");
		sql.append("        SAM_MEDICAL_BALANCE E  \n");
		sql.append("  WHERE 1 = 1 \n");
		String sex =(String) paramSet.getParameter("sex");
		if(StringUtils.isNotEmpty(sex)){
			sql.append("  AND E.SEX='"+sex+"'  \n");
		}
		String disease =(String) paramSet.getParameter("disease");
		if(StringUtils.isNotEmpty(disease)){
			sql.append("  AND E.DISEASE='"+disease+"'  \n");
		}
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append("  AND E.DOMICILE_CODE LIKE'"+getAreaCodeLikePrefix(domicileCode) + "%'  \n");
		}
		String beginTime =(String) paramSet.getParameter("beginTime");
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append("   AND E.BALANCE_TIME>='" + beginTime + "'");
		}
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append("   AND E.HOSPITAL_ID='" + hospitalId + "' \n");
		}
		String endTime =(String) paramSet.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append("  AND E.BALANCE_TIME<='" + endTime + "' \n");
		}
		String hospotalArea =(String) paramSet.getParameter("hospotalArea");
		if(StringUtils.isNotEmpty(hospotalArea)){
			sql.append("  AND E.HOSPOTALAREA ='" + hospotalArea + "' \n");
		}
		String regId =(String) paramSet.getParameter("regId");
		if(StringUtils.isNotEmpty(regId)){
			sql.append("  AND E.REG_ID = '" + regId + "'");
		}
		String name =(String) paramSet.getParameter("name");
		if(StringUtils.isNotEmpty(name)){
			sql.append("  and E.name='" + name + "'");
		}
		String idCard =(String) paramSet.getParameter("idCard");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" and E.ID_CARD='" + idCard + "'");
		}
		String sAge =(String) paramSet.getParameter("sAge");
		if(StringUtils.isNotEmpty(sAge)){
			sql.append("  AND E.BIRTHDAY <= '" + sAge + "' \n");
		}
		String eAge =(String) paramSet.getParameter("eAge");
		if(StringUtils.isNotEmpty(eAge)){
			sql.append("  AND E.BIRTHDAY >= '" + eAge + "' \n");
		}
		String dataSource =(String) paramSet.getParameter("dataSource");
		if(StringUtils.isNotEmpty(dataSource)){
			sql.append("  AND E.DATA_SOURCE = '" + dataSource + "' \n");
		}
		String qAssistanceType =(String) paramSet.getParameter("qAssistanceType");
		if(StringUtils.isNotEmpty(qAssistanceType)){
			sql.append("  AND E.ASSITANCE_TYPE = '" + qAssistanceType + "' \n");
		}
		sql.append("  AND E.STATUS ='2' \n");
		sql.append("  ORDER BY  E.BALANCE_TIME DESC \n");
		return executeDataset(sql.toString(),getDsStart(paramSet),getDsLimit(paramSet),true);
	}
	/**
	 * 优抚查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForBpt(ParameterSet paramSet){
		StringBuffer sql=new StringBuffer();
		sql.append("select to_char(round(sum(TOTAL_EXPENSE),2),'FM99,999,999,990.00')as  sumTotalExp,");
		sql.append("to_char(round(sum(INSURANCE_EXPENSE),2),'FM99,999,999,990.00')as  sumInsExp,");
		sql.append("to_char(round(sum(INSURANCE_PAY),2),'FM99,999,999,990.00')as  sumInsPay,");
		sql.append("to_char(round(sum(HOSPITAL_PAY),2) ,'FM99,999,999,990.00')as sumHospitalPay,");
		sql.append("to_char(round(sum(ILLNESS_INSURANCE_PAY),2) ,'FM99,999,999,990.00')as ILLNESS_INSURANCE_PAY,");
		sql.append("to_char(round(sum(SPECIAL_PAY),2),'FM99,999,999,990.00')as  sumSpecialPay,");
		sql.append("to_char(round(sum(PERSONAL_PAY),2) ,'FM99,999,999,990.00')as sumPersonalPay,");
		sql.append("count(*) num,");
		sql.append("a.bpt_Type \n");
		String hospitalId =(String) paramSet.getParameter("hospitalId");
		String hospitalArea =(String) paramSet.getParameter("hospitalArea");
		String bptType =(String) paramSet.getParameter("bptType");
		String domicileCode =(String) paramSet.getParameter("domicileCode");
		String currentJsp =(String) paramSet.getParameter("currentJsp");
		if("hos".equals(currentJsp)){
			sql.append(",hospital_id \n");
			sql.append("from sam_medical_balance a \n");
			sql.append(" where balance_Time is not null and a.bpt_Type is not null        \n");
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append("and hospital_Id='" + hospitalId + "' \n");
			}
			if(StringUtils.isNotEmpty(bptType)){
				sql.append("and a.bpt_Type='" + bptType + "'");
			}
			if(StringUtils.isNotEmpty(hospitalArea)){
				sql.append("and HOSPITAL_AREA like'" + getAreaCodeLikePrefix(hospitalArea) + "%' \n");
			}
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append("and hospital_Area like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			String regId =(String) paramSet.getParameter("regId");
			if(StringUtils.isNotEmpty(regId)){
				sql.append(" and a.REG_ID = '" + regId + "'");
			}
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append("and balance_Time>='" + beginTime + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append("and balance_Time<='" + endTime + "' \n");
			}
			sql.append("group by hospital_id,bpt_Type \n");
		}else if("dom".equals(currentJsp)){
			int index=6;
			if(StringUtils.isNotEmpty(domicileCode)){
				if(domicileCode.indexOf("000")<6&&domicileCode.indexOf("000")>0){
					index=domicileCode.indexOf("000")+2;
				}
			}
			sql.append(",rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0') DOMICILE_CODE \n");
			sql.append("from sam_medical_balance a   \n");
			sql.append("where 1=1 \n");
			sql.append(" and a.balance_Time is not null and a.bpt_Type is not null             \n");
			String beginTime =(String) paramSet.getParameter("beginTime");
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append("and b.DOMICILE_CODE like'" + getAreaCodeLikePrefix(domicileCode) + "%' \n");
			}
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append("and hospital_Id='" + hospitalId + "' \n");
			}
			if(StringUtils.isNotEmpty(beginTime)){
				sql.append("and balance_Time>='" + beginTime + "'");
			}
			if(StringUtils.isNotEmpty(bptType)){
				sql.append("and a.bpt_Type='" + bptType + "'");
			}
			String regId =(String) paramSet.getParameter("regId");
			if(StringUtils.isNotEmpty(regId)){
				sql.append(" and a.REG_ID = '" + regId + "'");
			}
			String endTime =(String) paramSet.getParameter("endTime");
			if(StringUtils.isNotEmpty(endTime)){
				sql.append("and balance_Time<='" + endTime + "' \n");
			}
			sql.append("group by  rpad(substr(DOMICILE_CODE,1,"+index+"),12,'0'),a.bpt_Type \n");
		}else{
			sql.append("from sam_medical_balance \n");
		}
		return executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(), true);
	}
	
	/**
	 * 优抚明细查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryYfDetail(ParameterSet paramSet){
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.name,a.sex,a.DOMICILE_CODE,a.HOSPITAL_ID,a.BPT_TYPE,a.DISABILITY_LEVEL_CODE,a.BPT_CARD_NO,a.BALANCE_TIME,a.TOTAL_EXPENSE,a.INSURANCE_EXPENSE,a.INSURANCE_PAY,a.SPECIAL_PAY,a.PERSONAL_PAY    \n");
		sql.append(" from sam_medical_balance a    \n");
		sql.append(" where 1=1                   \n");

		String domicileCode = (String) paramSet.getParameter("domicileCode");
		String bptType = (String) paramSet.getParameter("bptType");
		String hospitalId = (String) paramSet.getParameter("hospitalId");
		String beginTime =(String) paramSet.getParameter("beginTime");
		String endTime = (String) paramSet.getParameter("endTime");
		String currentJsp =(String) paramSet.getParameter("currentJsp");
		String regId =(String) paramSet.getParameter("regId");
		if(StringUtils.isNotEmpty(regId)){
			sql.append(" and a.REG_ID = '" + regId + "'");
		}
		if(currentJsp.equals("dom")){
			//优抚对象所在地和优抚类型
			if(StringUtils.isNotEmpty(domicileCode)){
				sql.append(" and a.DOMICILE_CODE like '"+getAreaCodeLikePrefix(domicileCode)+"%'   \n");
			}
			if(StringUtils.isNotEmpty(bptType)){
				sql.append(" and a.BPT_TYPE = '"+bptType+"'   \n");
			}
		}else if(currentJsp.equals("hos")){
			//医院和优抚类型
			if(StringUtils.isNotEmpty(hospitalId)){
				sql.append(" and a.hospital_Id ='"+hospitalId+"'   \n");
			}
			if(StringUtils.isNotEmpty(bptType)){
				sql.append(" and a.BPT_TYPE = '"+bptType+"'   \n");
			}
		}
		//结算时间
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" and a.balance_Time>='" + beginTime + "'");
		}
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" and a.balance_Time<='" + endTime + "'");
		}
		sql.append(" and balance_Time is not null and a.bpt_Type is not null   \n");
		DataSet ds= executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(),true);
		return ds;
	}
	
	/**
	 * 低保、五保救助对象中，重度残疾（1、2级伤残）、优抚对象、老年人数量和比例统计
	 * @param paramSet
	 * @return
	 */
	
	public DataSet queryBptDisOld(ParameterSet paramSet){
		StringBuffer sql = new StringBuffer();
		sql.append("  select  sum(case  when a.bpt_type is not null  then 1 else 0 end) bptNum, \n");
		sql.append("  sum(case when s.disability_level in ('1','2') then 1 else 0 end ) notBptType, \n");	
		
		String age = (String) paramSet.getParameter("age");
		if(StringUtils.isNotEmpty(age)){
			sql.append("  sum(case when substr(b.birthday, 0, 4) <= to_number(to_char(sysdate, 'yyyy'))-'"+age+"' then 1 else 0 end) oldNum, \n");
		}
		sql.append("  count(a.balance_id) num \n");	
		sql.append("  from baseinfo_people b \n");
		sql.append("  left outer join sam_people_disability s on b.people_id=s.people_id \n");
		sql.append("  left outer join sam_medical_balance a on b.people_id=a.people_id \n");
		sql.append("  where a.assitance_type in ('01','02','03') \n");
		
		String organArea =(String) paramSet.getParameter("organArea");
		if(StringUtils.isNotEmpty(organArea)){
			sql.append("  and b.DOMICILE_CODE like'"+getAreaCodeLikePrefix(organArea) + "%' \n");
		}
		sql.append(" and b.domicile_type!=2 \n");
		sql.append("and a.balance_Time is not null");
		int start = paramSet.getPageStart();
		int limit = paramSet.getPageLimit();
		return this.executeDataset(sql.toString(),start,limit,true);
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
}
