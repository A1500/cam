package com.inspur.cams.sorg.jxcheck.somjxcheck.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.sorg.jxcheck.util.JxCheckProperties;

/**
 * @title:SomJxCheckDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxCheckDao extends EntityDao<SomJxCheck> implements ISomJxCheckDao {

	public SomJxCheckDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxCheck.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxCheck");
	}

	public DataSet queryNoCheck(ParameterSet pset){
		String areaCode = (String) pset.getParameter("areaCode");
		String sorgType = (String) pset.getParameter("sorgType");
		String checkYear = (String) pset.getParameter("checkYear");
		String userName = (String) pset.getParameter("userName");
		StringBuffer sql = new StringBuffer("select USER_ID,USER_NAME,AREA_CODE from COM_EXT_USER where ORGAN_TYPE = ? and AREA_CODE like ? and USER_ID not in (select FILL_PEOPLE_ID from SOM_JX_CHECK where FILL_PEOPLE_AREA like ? and SORG_TYPE = ? and CHECK_YEAR = ?)");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		DataSet ds = new DataSet();
		if(areaCode!=null && !("".endsWith(areaCode)) && sorgType!=null && !("".endsWith(sorgType)) && checkYear!=null && !("".endsWith(checkYear))){
			String organType = "";
			if(sorgType.endsWith("S")){
				organType = "ST";
			}
			if(sorgType.endsWith("M")){
				organType = "MF";
			}
			if(sorgType.endsWith("J")){
				organType = "JJ";
			}
			typeList.add(Types.VARCHAR);
			objsList.add(organType);
			typeList.add(Types.VARCHAR);
			objsList.add(areaCode);
			typeList.add(Types.VARCHAR);
			objsList.add(areaCode);
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
			if(userName!=null && !("".endsWith(userName))){
				sql.append(" and USER_NAME = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(userName);
			}
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs ,pset.getPageStart(),pset.getPageLimit(),true);
		}
		return ds;
	}

	public void updateStatus(String taskCode, String status ,String correctNotReason) {
		int[] types = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		Object[] objs = new Object[] { status,correctNotReason,taskCode };
		executeUpdate("UPDATE SOM_JX_CHECK SET STATUS=?,CORRECT_NOT_REASON=? WHERE TASK_CODE=?",types, objs);
		
	}
	//##########################################         社团年检汇报               ################################################		
	public DataSet queryGroupCheckReport(ParameterSet pset){
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		String taskCodes = (String) pset.getParameter("TASK_CODE");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("select sum(DECODE(T.CHECK_RESULT,'4',1,0)) as ONE_YEAR,"+
										       "sum(DECODE(T.CHECK_RESULT,'5',1,0)) as TWO_YEAR,"+
											   "sum(A.UNITS_NUM) as UNITS_NUM,"+
										       "sum(A.PEOPLE_NUM) as PEOPLE_NUM,"+
										       "sum(A.COUNCIL_NUM) as COUNCIL_NUM,"+
										       "sum(A.STAND_COUNCIL_NUM) as STAND_COUNCIL_NUM,"+
										       "sum(A.AUDITOR_NUM) as AUDITOR_NUM,"+
										       "sum(A.SECRETARY_NUM) as SECRETARY_NUM,"+
										       "sum(A.DAILY_NUM) as DAILY_NUM,"+
										       "sum(A.ORGAN_NUM) as ORGAN_NUM,"+
										       "sum(A.SPECIAL_NUM) as SPECIAL_NUM,"+
										       "sum(A.ENTITY_NUM) as ENTITY_NUM,"+
										       "sum(B.PRACTITIONER_NUM) as PRACTITIONER_NUM,"+
										       "sum(B.FULLTIME_CONTRACT_NUM) as FULLTIME_CONTRACT_NUM,"+
										       "sum(B.RETIRED_NUM) as RETIRED_NUM,"+
										       "sum(B.PARTTIME_GOV_NUM) as PARTTIME_GOV_NUM,"+
										       "sum(B.ENTERPRISES_NUM) as ENTERPRISES_NUM,"+
										       "sum(B.OTHER_NUM) as OTHER_NUM,"+
										       "sum(B.UNDER_THIRTYFIVE_NUM) as UNDER_THIRTYFIVE_NUM,"+
										       "sum(B.THIRTYSIX_TO_FIFTY_NUM) as THIRTYSIX_TO_FIFTY_NUM,"+
										       "sum(B.FIFTYONE_TO_SIXTY_NUM) as FIFTYONE_TO_SIXTY_NUM,"+
										       "sum(B.ABOVE_SIXTY_NUM) as ABOVE_SIXTY_NUM,"+
										       "sum(B.UNDER_HIGHSCHOOL_NUM) as UNDER_HIGHSCHOOL_NUM,"+
										       "sum(B.UNIVERSITY_NUM) as UNIVERSITY_NUM,"+
										       "sum(B.ABOVE_MASTER_NUM) as ABOVE_MASTER_NUM,"+
										       "sum(B.FROM_ABROAD_NUM) as FROM_ABROAD_NUM,"+
										       "sum(B.CASEWORKER_NUM) as CASEWORKER_NUM,"+
										       "sum(B.VAWIRRMQ_NUM) as VAWIRRMQ_NUM,"+
										       "sum(B.ABOVE_COUNTY_NUM) as ABOVE_COUNTY_NUM,"+
										       "sum(B.PARTY_NUM_PROVINCE) as PARTY_NUM_PROVINCE,"+
										       "sum(B.PARTY_NUM_NATION) as PARTY_NUM_NATION,"+
										       "sum(B.NPC_NUM) as NPC_NUM,"+
										       "sum(B.NPC_NUM_PROVINCE) as NPC_NUM_PROVINCE,"+
										       "sum(B.NPC_NUM_NATION) as NPC_NUM_NATION,"+
										       "sum(B.CPPCC_NUM) as CPPCC_NUM,"+
										       "sum(B.CPPCC_NUM_PROVINCE) as CPPCC_NUM_PROVINCE,"+
										       "sum(B.CPPCC_NUM_NATION) as CPPCC_NUM_NATION,"+
										       "sum(B.PROVINCIAL_NUM) as PROVINCIAL_NUM,"+
										       "sum(B.BOARD_NUM) as BOARD_NUM,"+
										       "sum(B.CHUJI_NUM) as CHUJI_NUM,"+
										       "sum(B.PRINCIPAL_NUM) as PRINCIPAL_NUM,"+
										       "sum(B.WOMEN_PRINCIPAL_NUM) as WOMEN_PRINCIPAL_NUM,"+
										       "sum(B.WOMAN_PRAC_NUM) as WOMAN_PRAC_NUM,"+
										       "sum(B.FULLTIME_NUM) as FULLTIME_NUM,"+
										       "sum(C.GENERAL_TIMES) as GENERAL_TIMES,"+
										       "sum(C.COUNCIL_TIMES) as COUNCIL_TIMES,"+
										       "sum(C.LEARN_MEETING_TIMES) as LEARN_MEETING_TIMES,"+
										       "sum(C.TRAIN_TIMES) as TRAIN_TIMES,"+
										       "sum(C.TRAIN_NUM) as TRAIN_NUM,"+
										       "sum(C.COMMONWEAL_NUM) as COMMONWEAL_NUM,"+
										       "sum(C.COMMONWEAL_TIMES) as COMMONWEAL_TIMES,"+
										       "sum(C.COMMONWEAL_OUT) as COMMONWEAL_OUT,"+
										       "sum(C.INT_ITEM_NUM) as INT_ITEM_NUM,"+
										       "sum(C.INT_ITEM_MONEY) as INT_ITEM_MONEY,"+
										       "sum(C.MEETING_TIMES) as MEETING_TIMES,"+
										       "sum(C.OUT_TO_TIMES) as OUT_TO_TIMES,"+
										       "sum(C.OUT_TO_NUM) as OUT_TO_NUM,"+
										       "sum(C.FROM_OFF_TIMES) as FROM_OFF_TIMES,"+
										       "sum(C.FROM_OFF_NUM) as FROM_OFF_NUM,"+
										       "sum(C.ACCEPT_OFF_NUM) as ACCEPT_OFF_NUM,"+
										       "sum(C.ACCEPT_OFF_MONEY) as ACCEPT_OFF_MONEY,"+
										       "sum(C.RETAIN_PEOPLE_NUM) as RETAIN_PEOPLE_NUM,"+
										       // TODO 党建
										       "sum(DECODE(D.IF_BUILD_PARTY,'1',1,0)) as IF_BUILD_PARTY1,"+
										       "sum(D.PARTY_WORKER_NUM) as PARTY_WORKER_NUM,"+
										       "sum(DECODE(D.PARTY_TYPE,'1',1,0)) as PARTY_TYPE1,"+
										       "sum(DECODE(D.PARTY_TYPE,'2',1,0)) as PARTY_TYPE2,"+
										       "sum(DECODE(D.PARTY_TYPE,'3',1,0)) as PARTY_TYPE3,"+
										       "sum(DECODE(D.PARTY_TYPE,'4',1,0)) as PARTY_TYPE4,"+
										       "sum(DECODE(D.PARTY_TYPE,'5',1,0)) as PARTY_TYPE5,"+
										       "sum(DECODE(D.PARTY_TYPE,'6',1,0)) as PARTY_TYPE6,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'1',1,0)) as PARTY_RELATION_TYPE1,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'2',1,0)) as PARTY_RELATION_TYPE2,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'3',1,0)) as PARTY_RELATION_TYPE3,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'4',1,0)) as PARTY_RELATION_TYPE4,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'5',1,0)) as PARTY_RELATION_TYPE5,"+
										       "sum(DECODE(D.PARTY_SPACE,'1',1,0)) as PARTY_SPACE1,"+
										       "sum(DECODE(D.PARTY_SPACE,'2',1,0)) as PARTY_SPACE2,"+
										       "sum(DECODE(D.PARTY_SPACE,'3',1,0)) as PARTY_SPACE3,"+
										       "sum(DECODE(D.PARTY_SPACE,'4',1,0)) as PARTY_SPACE4,"+
										       "sum(DECODE(D.PARTY_SPACE,'5',1,0)) as PARTY_SPACE5,"+
										       "sum(D.PARTY_ACTIVITY_MON) as PARTY_ACTIVITY_MON,"+
										       "sum(D.PARTY_DUES_MON) as PARTY_DUES_MON,"+
										       "sum(D.PARTY_SUPPORT_MON) as PARTY_SUPPORT_MON,"+
										       "sum(D.PARTY_BUSINESS_MON) as PARTY_BUSINESS_MON,"+
										       "sum(D.PARTY_FINANCE_MON) as PARTY_FINANCE_MON,"+
										       "sum(D.PARTY_OTHER_MON) as PARTY_OTHER_MON,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'1',1,0)) as PARTY_PEOPLE_TYPE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'2',1,0)) as PARTY_PEOPLE_TYPE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'3',1,0)) as PARTY_PEOPLE_TYPE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'1',1,0)) as PARTY_PEOPLE_AGE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'2',1,0)) as PARTY_PEOPLE_AGE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'3',1,0)) as PARTY_PEOPLE_AGE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'4',1,0)) as PARTY_PEOPLE_AGE4,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'1',1,0)) as PARTY_PEOPLE_EDU1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'2',1,0)) as PARTY_PEOPLE_EDU2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'3',1,0)) as PARTY_PEOPLE_EDU3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'4',1,0)) as PARTY_PEOPLE_EDU4,"+
										       "sum(D.PARTY_MEMBER_TOTAL) as PARTY_MEMBER_TOTAL,"+
										       "sum(D.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM,"+
										       "sum(D.LEGAL_PARTY_NUM) as LEGAL_PARTY_NUM,"+
										       "sum(D.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_MASTER_NUM) as PARTY_MASTER_NUM,"+
										       "sum(D.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM,"+
										       "sum(D.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM,"+
										       "sum(D.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM,"+
										       "sum(D.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM,"+
										       "sum(D.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM,"+
										       "sum(D.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM,"+
										       "sum(D.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM,"+
										       "sum(D.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_SELF,'1',1,0)) as PARTY_STUDY_WAY_SELF1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_TALK,'1',1,0)) as PARTY_STUDY_WAY_TALK1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_CHAIR,'1',1,0)) as PARTY_STUDY_WAY_CHAIR1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_VISIT,'1',1,0)) as PARTY_STUDY_WAY_VISIT1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_ART,'1',1,0)) as PARTY_STUDY_WAY_ART1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_OTHER,'1',1,0)) as PARTY_STUDY_WAY_OTHER1,"+
										       "sum(D.PARTY_PARTY_NUM) as PARTY_PARTY_NUM,"+
										       "sum(D.PARTY_BORG_NUM) as PARTY_BORG_NUM,"+
										       "sum(D.PARTY_LINKED_NUM) as PARTY_LINKED_NUM,"+
										       "sum(D.PARTY_COLONY_NUM) as PARTY_COLONY_NUM,"+
										       "sum(D.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM,"+
										       "sum(D.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM,"+
										       "sum(D.PARTY_ACTIVITY_NUM) as PARTY_ACTIVITY_NUM,"+
										       "sum(D.ACTIVITY_GOOD_NUM) as ACTIVITY_GOOD_NUM,"+
										       
										       "sum(DECODE(G.IF_BUILD_PARTY,'0',1,0)) as IF_BUILD_PARTY0,"+
										       "sum(DECODE(G.IF_PARTY_OFFICER,'1',1,0)) as IF_PARTY_OFFICER1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'1',1,0)) as NO_BUILD_PARTY_RESON1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'2',1,0)) as NO_BUILD_PARTY_RESON2,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'3',1,0)) as NO_BUILD_PARTY_RESON3,"+
										       "sum(G.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM_A,"+
										       "sum(G.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM_A,"+
										       "sum(G.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM_A,"+
										       "sum(G.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_MASTER_NUM) as PARTY_MASTER_NUM_A,"+
										       "sum(G.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM_A,"+
										       "sum(G.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM_A,"+
										       "sum(G.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM_A,"+
										       "sum(G.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM_A,"+
										       "sum(G.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM_A,"+
										       "sum(G.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM_A,"+
										       "sum(G.PARTY_BORG_NUM) as PARTY_BORG_NUM_A,"+
										       "sum(G.PARTY_LINKED_NUM) as PARTY_LINKED_NUM_A,"+
										       "sum(G.PARTY_COLONY_NUM) as PARTY_COLONY_NUM_A,"+
										       "sum(G.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM_A,"+
										       "sum(G.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM_A,"+

										       
										       "sum(E.LAST_TOTAL) as LAST_TOTAL,"+
										       "sum(E.EARNING_TOTAL) as EARNING_TOTAL,"+
										       "sum(E.SERVICE_EARNING) as SERVICE_EARNING,"+
										       "sum(E.FEE_EARNING) as FEE_EARNING,"+
										       "sum(E.ACCEPT_EARNING) as ACCEPT_EARNING,"+
										       "sum(E.ASSISTANCE_EARNING) as ASSISTANCE_EARNING,"+
										       "sum(E.OTHER_EARNING) as OTHER_EARNING,"+
										       "sum(E.CHARGE_TOTAL) as CHARGE_TOTAL,"+
										       "sum(E.APPLY_CHARGE) as APPLY_CHARGE,"+
										       "sum(E.COMWEAL_CHARGE) as COMWEAL_CHARGE,"+
										       "sum(E.MANAGE_CHARGE) as MANAGE_CHARGE,"+
										       "sum(E.PAY_CHARGE) as PAY_CHARGE,"+
										       "sum(E.OFFICE_CHARGE) as OFFICE_CHARGE,"+
										       "sum(E.OTHER_CHARGE) as OTHER_CHARGE,"+
										       "sum(E.MANAGE_OTHER_CHARGE) as MANAGE_OTHER_CHARGE,"+
										       "sum(E.NET_TOTAL) as NET_TOTAL,"+
										       "sum(E.TAX_TOTAL) as TAX_TOTAL,"+
										       "sum(E.SALES_TAX) as SALES_TAX,"+
										       "sum(E.INCOME_TAX) as INCOME_TAX,"+
										       "sum(E.OTHER_TAX) as OTHER_TAX,"+
										       "sum(E.ORGAN_EARNING) as ORGAN_EARNING,"+
										       "sum(F.CA_MONEYFUNDS_S) as CA_MONEYFUNDS_S,"+
										       "sum(F.CA_LIQUID_INVESTMENT_S) as CA_LIQUID_INVESTMENT_S,"+
										       "sum(F.CA_MONEYFUNDS_E) as CA_MONEYFUNDS_E,"+
										       "sum(F.CA_LIQUID_INVESTMENT_E) as CA_LIQUID_INVESTMENT_E,"+
										       "sum(F.CA_RECEIVABLES_S) as CA_RECEIVABLES_S,"+
										       "sum(F.CA_RECEIVABLES_E) as CA_RECEIVABLES_E,"+
										       "sum(F.CA_ADVANCE_MONEY_S) as CA_ADVANCE_MONEY_S,"+
										       "sum(F.CA_ADVANCE_MONEY_E) as CA_ADVANCE_MONEY_E,"+
										       "sum(F.CA_INVENTORY_S) as CA_INVENTORY_S,"+
										       "sum(F.CA_INVENTORY_E) as CA_INVENTORY_E,"+
										       "sum(F.CA_DEFERRED_EXPENSES_S) as CA_DEFERRED_EXPENSES_S,"+
										       "sum(F.CA_DEFERRED_EXPENSES_E) as CA_DEFERRED_EXPENSES_E,"+
										       "sum(F.CA_DEBT_INVESTMENTS_S) as CA_DEBT_INVESTMENTS_S,"+
										       "sum(F.CA_DEBT_INVESTMENTS_E) as CA_DEBT_INVESTMENTS_E,"+
										       "sum(F.CA_OTHERS_S) as CA_OTHERS_S,"+
										       "sum(F.CA_SUM_S) as CA_SUM_S,"+
										       "sum(F.CL_SHORTTERM_BORROWING_S) as CL_SHORTTERM_BORROWING_S,"+
										       "sum(F.CL_SHORTTERM_BORROWING_E) as CL_SHORTTERM_BORROWING_E,"+
										       "sum(F.CL_DUES_S) as CL_DUES_S,"+
										       "sum(F.CL_DUES_E) as CL_DUES_E,"+
										       "sum(F.CL_ACCRUED_PAYROLLS_S) as CL_ACCRUED_PAYROLLS_S,"+
										       "sum(F.CL_ACCRUED_PAYROLLS_E) as CL_ACCRUED_PAYROLLS_E,"+
										       "sum(F.CL_TAS_PAYABLE_S) as CL_TAS_PAYABLE_S,"+
										       "sum(F.CL_TAS_PAYABLE_E) as CL_TAS_PAYABLE_E,"+
										       "sum(F.CL_DEPOSIT_RECEIVED_S) as CL_DEPOSIT_RECEIVED_S,"+
										       "sum(F.CL_DEPOSIT_RECEIVED_E) as CL_DEPOSIT_RECEIVED_E,"+
										       "sum(F.CL_ACCRUED_EXPENSES_S) as CL_ACCRUED_EXPENSES_S,"+
										       "sum(F.CL_ACCRUED_EXPENSES_E) as CL_ACCRUED_EXPENSES_E,"+
										       "sum(F.CL_ACCRUED_LIABILITIES_S) as CL_ACCRUED_LIABILITIES_S,"+
										       "sum(F.CL_ACCRUED_LIABILITIES_E) as CL_ACCRUED_LIABILITIES_E,"+
										       "sum(F.CL_LONGTERM_DUE_S) as CL_LONGTERM_DUE_S,"+
										       "sum(F.CL_LONGTERM_DUE_E) as CL_LONGTERM_DUE_E,"+
										       "sum(F.CL_OTHERS_S) as CL_OTHERS_S,"+
										       "sum(F.CA_OTHERS_E) as CA_OTHERS_E,"+
										       "sum(F.CA_SUM_E) as CA_SUM_E,"+
										       "sum(F.CL_OTHERS_E) as CL_OTHERS_E,"+
										       "sum(F.CL_SUM_S) as CL_SUM_S,"+
										       "sum(F.CL_SUM_E) as CL_SUM_E,"+
										       "sum(F.PI_LONGTERM_EQUITY_INV_S) as PI_LONGTERM_EQUITY_INV_S,"+
										       "sum(F.PI_LONGTERM_EQUITY_INV_E) as PI_LONGTERM_EQUITY_INV_E,"+
										       "sum(F.PI_LONGTERM_DEBT_INV_S) as PI_LONGTERM_DEBT_INV_S,"+
										       "sum(F.PI_LONGTERM_DEBT_INV_E) as PI_LONGTERM_DEBT_INV_E,"+
										       "sum(F.PI_SUM_S) as PI_SUM_S,"+
										       "sum(F.PI_SUM_E) as PI_SUM_E,"+
										       "sum(F.LL_LONGTERM_LOANS_S) as LL_LONGTERM_LOANS_S,"+
										       "sum(F.LL_LONGTERM_LOANS_E) as LL_LONGTERM_LOANS_E,"+
										       "sum(F.LL_LONGTERM_PAYABLE_S) as LL_LONGTERM_PAYABLE_S,"+
										       "sum(F.LL_LONGTERM_PAYABLE_E) as LL_LONGTERM_PAYABLE_E,"+
										       "sum(F.LL_OTHERS_S) as LL_OTHERS_S,"+
										       "sum(F.LL_OTHERS_E) as LL_OTHERS_E,"+
										       "sum(F.LL_SUM_S) as LL_SUM_S,"+
										       "sum(F.LL_SUM_E) as LL_SUM_E,"+
										       "sum(F.FA_PRIME_COST_S) as FA_PRIME_COST_S,"+
										       "sum(F.FA_PRIME_COST_E) as FA_PRIME_COST_E,"+
										       "sum(F.FA_ACCUMULATED_DEPRECIATION_S) as FA_ACCUMULATED_DEPRECIATION_S,"+
										       "sum(F.FA_ACCUMULATED_DEPRECIATION_E) as FA_ACCUMULATED_DEPRECIATION_E,"+
										       "sum(F.FA_NET_VALUE_S) as FA_NET_VALUE_S,"+
										       "sum(F.FA_NET_VALUE_E) as FA_NET_VALUE_E,"+
										       "sum(F.FA_CONSTRUCTION_IN_PROCESS_S) as FA_CONSTRUCTION_IN_PROCESS_S,"+
										       "sum(F.FA_CONSTRUCTION_IN_PROCESS_E) as FA_CONSTRUCTION_IN_PROCESS_E,"+
										       "sum(F.FA_CULTURAL_HERITAGE_S) as FA_CULTURAL_HERITAGE_S,"+
										       "sum(F.FA_CULTURAL_HERITAGE_E) as FA_CULTURAL_HERITAGE_E,"+
										       "sum(F.FA_DISPOSAL_FIXED_ASSETS_S) as FA_DISPOSAL_FIXED_ASSETS_S,"+
										       "sum(F.FA_DISPOSAL_FIXED_ASSETS_E) as FA_DISPOSAL_FIXED_ASSETS_E,"+
										       "sum(F.FA_SUM_S) as FA_SUM_S,"+
										       "sum(F.FA_SUM_E) as FA_SUM_E,"+
										       "sum(F.PA_DEBT_S) as PA_DEBT_S,"+
										       "sum(F.PA_DEBT_E) as PA_DEBT_E,"+
										       "sum(F.PA_SUM_S) as PA_SUM_S,"+
										       "sum(F.PA_SUM_E) as PA_SUM_E,"+
										       "sum(F.INTANGIBLE_ASSETS_S) as INTANGIBLE_ASSETS_S,"+
										       "sum(F.INTANGIBLE_ASSETS_E) as INTANGIBLE_ASSETS_E,"+
										       "sum(F.ENTRUSTED_AGENT_ASSETS_S) as ENTRUSTED_AGENT_ASSETS_S,"+
										       "sum(F.ENTRUSTED_AGENT_ASSETS_E) as ENTRUSTED_AGENT_ASSETS_E,"+
										       "sum(F.ASSETS_SUM_S) as ASSETS_SUM_S,"+
										       "sum(F.ASSETS_SUM_E) as ASSETS_SUM_E,"+
										       "sum(F.UNLIMIT_NET_ASSETS_S) as UNLIMIT_NET_ASSETS_S,"+
										       "sum(F.UNLIMIT_NET_ASSETS_E) as UNLIMIT_NET_ASSETS_E,"+
										       "sum(F.LIMIT_NET_ASSETS_S) as LIMIT_NET_ASSETS_S,"+
										       "sum(F.LIMIT_NET_ASSETS_E) as LIMIT_NET_ASSETS_E,"+
										       "sum(F.NET_ASSETS_SUM_S) as NET_ASSETS_SUM_S,"+
										       "sum(F.NET_ASSETS_SUM_E) as NET_ASSETS_SUM_E,"+
										       "sum(F.DEBT_ASSETS_SUM_S) as DEBT_ASSETS_SUM_S,"+
										       "sum(F.DEBT_ASSETS_SUM_E) as DEBT_ASSETS_SUM_E "+
										     
										       " from SOM_JX_CHECK         		T "+
										       " left join SOM_JX_VIP_ORGAN     		A "+
										       		" on T.TASK_CODE = A.TASK_CODE "+
										       " left join SOM_JX_PEOPLE    B "+
										       		" on T.TASK_CODE = B.TASK_CODE"+
										       " left join SOM_JX_ACTIVITY      		C "+
										       		" on T.TASK_CODE = C.TASK_CODE"+
										       " left join SOM_JX_CHECK_PARTY   		D"+
										       		" on T.TASK_CODE = D.TASK_CODE and D.If_Build_Party='1'"+
										       " left join SOM_JX_CHECK_PARTY   		G"+
										       		" on T.TASK_CODE = G.TASK_CODE and G.If_Build_Party='0'"+
										       " left join SOM_JX_CHECK_FINANCE        E"+
										       		" on T.TASK_CODE = E.TASK_CODE"+
										       " left join SOM_JX_CHECK_BALANCE_SHEET  F "+
													" on T.TASK_CODE = F.TASK_CODE where 1=1   AND T.STATUS != '0' and T.STATUS != '4'");
		StringBuffer sql1 = new StringBuffer("select count(T.TASK_CODE) as TOTAL"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '0'"+
										  " and T.STATUS != '4'");
		StringBuffer sql2 = new StringBuffer("select count(T.TASK_CODE) as CHECK_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'");
		StringBuffer sql3 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NO_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '4'"+
										   " and T.STATUS != '0'"+
										   " and T.STATUS != '8'");
		StringBuffer sql4 = new StringBuffer("select count(T.TASK_CODE) as CHECK_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '1'");
		StringBuffer sql5 = new StringBuffer("select count(T.TASK_CODE) as CHECK_BASAL_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '2'");
		StringBuffer sql6 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NOT_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '0'");
		
		if(checkYear != null && !("".equals(checkYear.trim()))){
			sql.append(" and T.CHECK_YEAR = ? ");
			sql1.append(" and T.CHECK_YEAR = ? ");
			sql2.append(" and T.CHECK_YEAR = ? ");
			sql3.append(" and T.CHECK_YEAR = ? ");
			sql4.append(" and T.CHECK_YEAR = ? ");
			sql5.append(" and T.CHECK_YEAR = ? ");
			sql6.append(" and T.CHECK_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
		}
		if(taskCodes != null && !("".equals(taskCodes.trim())) && !("null".equals(taskCodes))){
			sql.append(" AND ( ");
			sql1.append(" AND ( ");
			sql2.append(" AND ( ");
			sql3.append(" AND ( ");
			sql4.append(" AND ( ");
			sql5.append(" AND ( ");
			sql6.append(" AND ( ");
			String[] ary = taskCodes.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.TASK_CODE=? ");
				sql1.append(" T.TASK_CODE=? ");
				sql2.append(" T.TASK_CODE=? ");
				sql3.append(" T.TASK_CODE=? ");
				sql4.append(" T.TASK_CODE=? ");
				sql5.append(" T.TASK_CODE=? ");
				sql6.append(" T.TASK_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
					sql1.append(" OR ");
					sql2.append(" OR ");
					sql3.append(" OR ");
					sql4.append(" OR ");
					sql5.append(" OR ");
					sql6.append(" OR ");
				}
			}
			sql.append(" ) ");
			sql1.append(" ) ");
			sql2.append(" ) ");
			sql3.append(" ) ");
			sql4.append(" ) ");
			sql5.append(" ) ");
			sql6.append(" ) ");
		}else{
			sql.append(" AND T.SORG_TYPE = ?");
			sql1.append(" AND T.SORG_TYPE = ?");
			sql2.append(" AND T.SORG_TYPE = ?");
			sql3.append(" AND T.SORG_TYPE = ?");
			sql4.append(" AND T.SORG_TYPE = ?");
			sql5.append(" AND T.SORG_TYPE = ?");
			sql6.append(" AND T.SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add("S");
		}
		DataSet ds = new DataSet();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
			
			list = this.executeQuery(sql1.toString(), types, args);
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		} else {
			ds = this.executeDataset(sql.toString(),true);
			
			list = this.executeQuery(sql1.toString());
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString());
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString());
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString());
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString());
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString());
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		}
		for (int i = 0; i < ds.getCount(); i++) {
			Record rd = ds.getRecord(i);
			Iterator<String> it = rd.keys();
			while(it.hasNext()){
				String nextValue = it.next();
				rd.set(nextValue,rd.get(nextValue)==null?"0":rd.get(nextValue));
			}
		}
		return ds;
	}
	//##########################################         民非年检汇报               ################################################		
	public DataSet queryUngovCheckReport(ParameterSet pset){
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		String taskCodes = (String) pset.getParameter("TASK_CODE");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("select sum(DECODE(T.CHECK_RESULT,'4',1,0)) as ONE_YEAR,"+
										       "sum(DECODE(T.CHECK_RESULT,'5',1,0)) as TWO_YEAR,"+
											   "sum(T.INITIAL_FUND) as INITIAL_FUND,"+
										       "sum(T.IN_SCHOOL_NUM) as IN_SCHOOL_NUM,"+
										       "sum(T.TRAIN_NUM) as TRAIN_NUM,"+
										       "sum(T.MEDICAL_NUM) as MEDICAL_NUM,"+
										       "sum(T.CULTURE_ACTIVITY_NUM) as CULTURE_ACTIVITY_NUM,"+
										       "sum(A.PRACTITIONER_NUM) as PRACTITIONER_NUM,"+
										       "sum(A.FULLTIME_CONTRACT_NUM) as FULLTIME_CONTRACT_NUM,"+
										       "sum(A.RETIRED_NUM) as RETIRED_NUM,"+
										       "sum(A.PARTTIME_GOV_NUM) as PARTTIME_GOV_NUM,"+
										       "sum(A.ENTERPRISES_NUM) as ENTERPRISES_NUM,"+
										       "sum(A.OTHER_NUM) as OTHER_NUM,"+
										       "sum(A.UNDER_THIRTYFIVE_NUM) as UNDER_THIRTYFIVE_NUM,"+
										       "sum(A.THIRTYSIX_TO_FIFTY_NUM) as THIRTYSIX_TO_FIFTY_NUM,"+
										       "sum(A.FIFTYONE_TO_SIXTY_NUM) as FIFTYONE_TO_SIXTY_NUM,"+
										       "sum(A.ABOVE_SIXTY_NUM) as ABOVE_SIXTY_NUM,"+
										       "sum(A.UNDER_HIGHSCHOOL_NUM) as UNDER_HIGHSCHOOL_NUM,"+
										       "sum(A.UNIVERSITY_NUM) as UNIVERSITY_NUM,"+
										       "sum(A.ABOVE_MASTER_NUM) as ABOVE_MASTER_NUM,"+
										       "sum(A.PRINCIPAL_NUM) as PRINCIPAL_NUM,"+
										       "sum(A.WOMEN_PRINCIPAL_NUM) as WOMEN_PRINCIPAL_NUM,"+
										       "sum(A.WOMAN_PRAC_NUM) as WOMAN_PRAC_NUM,"+
										       "sum(A.ABOVE_COUNTY_NUM) as ABOVE_COUNTY_NUM,"+
										       "sum(A.PARTY_NUM_PROVINCE) as PARTY_NUM_PROVINCE,"+
										       "sum(A.PARTY_NUM_NATION) as PARTY_NUM_NATION,"+
										       "sum(A.NPC_NUM) as NPC_NUM,"+
										       "sum(A.NPC_NUM_PROVINCE) as NPC_NUM_PROVINCE,"+
										       "sum(A.NPC_NUM_NATION) as NPC_NUM_NATION,"+
										       "sum(A.CPPCC_NUM) as CPPCC_NUM,"+
										       "sum(A.CPPCC_NUM_PROVINCE) as CPPCC_NUM_PROVINCE,"+
										       "sum(A.CPPCC_NUM_NATION) as CPPCC_NUM_NATION,"+
										       "sum(A.FULLTIME_NUM) as FULLTIME_NUM,"+
										       "sum(B.COUNCIL_NUM) as COUNCIL_NUM,"+
										       "sum(B.AUDITOR_NUM) as AUDITOR_NUM,"+
										       "sum(C.COUNCIL_TIMES) as COUNCIL_TIMES,"+
										       "sum(C.AUDITING_TIMES) as AUDITING_TIMES,"+
										       "sum(C.COMMONWEAL_NUM) as COMMONWEAL_NUM,"+
										       "sum(C.COMMONWEAL_TIMES) as COMMONWEAL_TIMES,"+
										       "sum(C.COMMONWEAL_OUT) as COMMONWEAL_OUT,"+
										      
										       // TODO 党建
										       "sum(DECODE(D.IF_BUILD_PARTY,'1',1,0)) as IF_BUILD_PARTY1,"+
										       "sum(D.PARTY_WORKER_NUM) as PARTY_WORKER_NUM,"+
										       "sum(DECODE(D.PARTY_TYPE,'1',1,0)) as PARTY_TYPE1,"+
										       "sum(DECODE(D.PARTY_TYPE,'2',1,0)) as PARTY_TYPE2,"+
										       "sum(DECODE(D.PARTY_TYPE,'3',1,0)) as PARTY_TYPE3,"+
										       "sum(DECODE(D.PARTY_TYPE,'4',1,0)) as PARTY_TYPE4,"+
										       "sum(DECODE(D.PARTY_TYPE,'5',1,0)) as PARTY_TYPE5,"+
										       "sum(DECODE(D.PARTY_TYPE,'6',1,0)) as PARTY_TYPE6,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'1',1,0)) as PARTY_RELATION_TYPE1,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'2',1,0)) as PARTY_RELATION_TYPE2,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'3',1,0)) as PARTY_RELATION_TYPE3,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'4',1,0)) as PARTY_RELATION_TYPE4,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'5',1,0)) as PARTY_RELATION_TYPE5,"+
										       "sum(DECODE(D.PARTY_SPACE,'1',1,0)) as PARTY_SPACE1,"+
										       "sum(DECODE(D.PARTY_SPACE,'2',1,0)) as PARTY_SPACE2,"+
										       "sum(DECODE(D.PARTY_SPACE,'3',1,0)) as PARTY_SPACE3,"+
										       "sum(DECODE(D.PARTY_SPACE,'4',1,0)) as PARTY_SPACE4,"+
										       "sum(DECODE(D.PARTY_SPACE,'5',1,0)) as PARTY_SPACE5,"+
										       "sum(D.PARTY_ACTIVITY_MON) as PARTY_ACTIVITY_MON,"+
										       "sum(D.PARTY_DUES_MON) as PARTY_DUES_MON,"+
										       "sum(D.PARTY_SUPPORT_MON) as PARTY_SUPPORT_MON,"+
										       "sum(D.PARTY_BUSINESS_MON) as PARTY_BUSINESS_MON,"+
										       "sum(D.PARTY_FINANCE_MON) as PARTY_FINANCE_MON,"+
										       "sum(D.PARTY_OTHER_MON) as PARTY_OTHER_MON,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'1',1,0)) as PARTY_PEOPLE_TYPE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'2',1,0)) as PARTY_PEOPLE_TYPE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'3',1,0)) as PARTY_PEOPLE_TYPE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'1',1,0)) as PARTY_PEOPLE_AGE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'2',1,0)) as PARTY_PEOPLE_AGE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'3',1,0)) as PARTY_PEOPLE_AGE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'4',1,0)) as PARTY_PEOPLE_AGE4,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'1',1,0)) as PARTY_PEOPLE_EDU1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'2',1,0)) as PARTY_PEOPLE_EDU2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'3',1,0)) as PARTY_PEOPLE_EDU3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'4',1,0)) as PARTY_PEOPLE_EDU4,"+
										       "sum(D.PARTY_MEMBER_TOTAL) as PARTY_MEMBER_TOTAL,"+
										       "sum(D.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM,"+
										       "sum(D.LEGAL_PARTY_NUM) as LEGAL_PARTY_NUM,"+
										       "sum(D.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_MASTER_NUM) as PARTY_MASTER_NUM,"+
										       "sum(D.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM,"+
										       "sum(D.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM,"+
										       "sum(D.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM,"+
										       "sum(D.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM,"+
										       "sum(D.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM,"+
										       "sum(D.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM,"+
										       "sum(D.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM,"+
										       "sum(D.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_SELF,'1',1,0)) as PARTY_STUDY_WAY_SELF1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_TALK,'1',1,0)) as PARTY_STUDY_WAY_TALK1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_CHAIR,'1',1,0)) as PARTY_STUDY_WAY_CHAIR1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_VISIT,'1',1,0)) as PARTY_STUDY_WAY_VISIT1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_ART,'1',1,0)) as PARTY_STUDY_WAY_ART1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_OTHER,'1',1,0)) as PARTY_STUDY_WAY_OTHER1,"+
										       "sum(D.PARTY_PARTY_NUM) as PARTY_PARTY_NUM,"+
										       "sum(D.PARTY_BORG_NUM) as PARTY_BORG_NUM,"+
										       "sum(D.PARTY_LINKED_NUM) as PARTY_LINKED_NUM,"+
										       "sum(D.PARTY_COLONY_NUM) as PARTY_COLONY_NUM,"+
										       "sum(D.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM,"+
										       "sum(D.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM,"+
										       "sum(D.PARTY_ACTIVITY_NUM) as PARTY_ACTIVITY_NUM,"+
										       "sum(D.ACTIVITY_GOOD_NUM) as ACTIVITY_GOOD_NUM,"+
										       
										       "sum(DECODE(G.IF_BUILD_PARTY,'0',1,0)) as IF_BUILD_PARTY0,"+
										       "sum(DECODE(G.IF_PARTY_OFFICER,'1',1,0)) as IF_PARTY_OFFICER1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'1',1,0)) as NO_BUILD_PARTY_RESON1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'2',1,0)) as NO_BUILD_PARTY_RESON2,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'3',1,0)) as NO_BUILD_PARTY_RESON3,"+
										       "sum(G.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM_A,"+
										       "sum(G.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM_A,"+
										       "sum(G.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM_A,"+
										       "sum(G.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_MASTER_NUM) as PARTY_MASTER_NUM_A,"+
										       "sum(G.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM_A,"+
										       "sum(G.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM_A,"+
										       "sum(G.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM_A,"+
										       "sum(G.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM_A,"+
										       "sum(G.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM_A,"+
										       "sum(G.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM_A,"+
										       "sum(G.PARTY_BORG_NUM) as PARTY_BORG_NUM_A,"+
										       "sum(G.PARTY_LINKED_NUM) as PARTY_LINKED_NUM_A,"+
										       "sum(G.PARTY_COLONY_NUM) as PARTY_COLONY_NUM_A,"+
										       "sum(G.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM_A,"+
										       "sum(G.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM_A,"+
										       
										       "sum(E.LAST_TOTAL) as LAST_TOTAL,"+
										       "sum(E.EARNING_TOTAL) as EARNING_TOTAL,"+
										       "sum(E.SERVICE_EARNING) as SERVICE_EARNING,"+
										       "sum(E.ORGAN_EARNING) as ORGAN_EARNING,"+
										       "sum(E.ACCEPT_EARNING) as ACCEPT_EARNING,"+
										       "sum(E.ASSISTANCE_EARNING) as ASSISTANCE_EARNING,"+
										       "sum(E.OTHER_EARNING) as OTHER_EARNING,"+
										       "sum(E.CHARGE_TOTAL) as CHARGE_TOTAL,"+
										       "sum(E.APPLY_CHARGE) as APPLY_CHARGE,"+
										       "sum(E.COMWEAL_CHARGE) as COMWEAL_CHARGE,"+
										       "sum(E.MANAGE_CHARGE) as MANAGE_CHARGE,"+
										       "sum(E.PAY_CHARGE) as PAY_CHARGE,"+
										       "sum(E.OFFICE_CHARGE) as OFFICE_CHARGE,"+
										       "sum(E.MANAGE_OTHER_CHARGE) as MANAGE_OTHER_CHARGE,"+
										       "sum(E.NET_TOTAL) as NET_TOTAL,"+
										       "sum(E.TAX_TOTAL) as TAX_TOTAL,"+
										       "sum(E.SALES_TAX) as SALES_TAX,"+
										       "sum(E.INCOME_TAX) as INCOME_TAX,"+
										       "sum(E.OTHER_TAX) as OTHER_TAX,"+
										       
										       "sum(F.CA_MONEYFUNDS_S) as CA_MONEYFUNDS_S,"+
										       "sum(F.CA_LIQUID_INVESTMENT_S) as CA_LIQUID_INVESTMENT_S,"+
										       "sum(F.CA_MONEYFUNDS_E) as CA_MONEYFUNDS_E,"+
										       "sum(F.CA_LIQUID_INVESTMENT_E) as CA_LIQUID_INVESTMENT_E,"+
										       "sum(F.CA_RECEIVABLES_S) as CA_RECEIVABLES_S,"+
										       "sum(F.CA_RECEIVABLES_E) as CA_RECEIVABLES_E,"+
										       "sum(F.CA_ADVANCE_MONEY_S) as CA_ADVANCE_MONEY_S,"+
										       "sum(F.CA_ADVANCE_MONEY_E) as CA_ADVANCE_MONEY_E,"+
										       "sum(F.CA_INVENTORY_S) as CA_INVENTORY_S,"+
										       "sum(F.CA_INVENTORY_E) as CA_INVENTORY_E,"+
										       "sum(F.CA_DEFERRED_EXPENSES_S) as CA_DEFERRED_EXPENSES_S,"+
										       "sum(F.CA_DEFERRED_EXPENSES_E) as CA_DEFERRED_EXPENSES_E,"+
										       "sum(F.CA_DEBT_INVESTMENTS_S) as CA_DEBT_INVESTMENTS_S,"+
										       "sum(F.CA_DEBT_INVESTMENTS_E) as CA_DEBT_INVESTMENTS_E,"+
										       "sum(F.CA_OTHERS_S) as CA_OTHERS_S,"+
										       "sum(F.CA_SUM_S) as CA_SUM_S,"+
										       "sum(F.CL_SHORTTERM_BORROWING_S) as CL_SHORTTERM_BORROWING_S,"+
										       "sum(F.CL_SHORTTERM_BORROWING_E) as CL_SHORTTERM_BORROWING_E,"+
										       "sum(F.CL_DUES_S) as CL_DUES_S,"+
										       "sum(F.CL_DUES_E) as CL_DUES_E,"+
										       "sum(F.CL_ACCRUED_PAYROLLS_S) as CL_ACCRUED_PAYROLLS_S,"+
										       "sum(F.CL_ACCRUED_PAYROLLS_E) as CL_ACCRUED_PAYROLLS_E,"+
										       "sum(F.CL_TAS_PAYABLE_S) as CL_TAS_PAYABLE_S,"+
										       "sum(F.CL_TAS_PAYABLE_E) as CL_TAS_PAYABLE_E,"+
										       "sum(F.CL_DEPOSIT_RECEIVED_S) as CL_DEPOSIT_RECEIVED_S,"+
										       "sum(F.CL_DEPOSIT_RECEIVED_E) as CL_DEPOSIT_RECEIVED_E,"+
										       "sum(F.CL_ACCRUED_EXPENSES_S) as CL_ACCRUED_EXPENSES_S,"+
										       "sum(F.CL_ACCRUED_EXPENSES_E) as CL_ACCRUED_EXPENSES_E,"+
										       "sum(F.CL_ACCRUED_LIABILITIES_S) as CL_ACCRUED_LIABILITIES_S,"+
										       "sum(F.CL_ACCRUED_LIABILITIES_E) as CL_ACCRUED_LIABILITIES_E,"+
										       "sum(F.CL_LONGTERM_DUE_S) as CL_LONGTERM_DUE_S,"+
										       "sum(F.CL_LONGTERM_DUE_E) as CL_LONGTERM_DUE_E,"+
										       "sum(F.CL_OTHERS_S) as CL_OTHERS_S,"+
										       "sum(F.CA_OTHERS_E) as CA_OTHERS_E,"+
										       "sum(F.CA_SUM_E) as CA_SUM_E,"+
										       "sum(F.CL_OTHERS_E) as CL_OTHERS_E,"+
										       "sum(F.CL_SUM_S) as CL_SUM_S,"+
										       "sum(F.CL_SUM_E) as CL_SUM_E,"+
										       "sum(F.PI_LONGTERM_EQUITY_INV_S) as PI_LONGTERM_EQUITY_INV_S,"+
										       "sum(F.PI_LONGTERM_EQUITY_INV_E) as PI_LONGTERM_EQUITY_INV_E,"+
										       "sum(F.PI_LONGTERM_DEBT_INV_S) as PI_LONGTERM_DEBT_INV_S,"+
										       "sum(F.PI_LONGTERM_DEBT_INV_E) as PI_LONGTERM_DEBT_INV_E,"+
										       "sum(F.PI_SUM_S) as PI_SUM_S,"+
										       "sum(F.PI_SUM_E) as PI_SUM_E,"+
										       "sum(F.LL_LONGTERM_LOANS_S) as LL_LONGTERM_LOANS_S,"+
										       "sum(F.LL_LONGTERM_LOANS_E) as LL_LONGTERM_LOANS_E,"+
										       "sum(F.LL_LONGTERM_PAYABLE_S) as LL_LONGTERM_PAYABLE_S,"+
										       "sum(F.LL_LONGTERM_PAYABLE_E) as LL_LONGTERM_PAYABLE_E,"+
										       "sum(F.LL_OTHERS_S) as LL_OTHERS_S,"+
										       "sum(F.LL_OTHERS_E) as LL_OTHERS_E,"+
										       "sum(F.LL_SUM_S) as LL_SUM_S,"+
										       "sum(F.LL_SUM_E) as LL_SUM_E,"+
										       "sum(F.FA_PRIME_COST_S) as FA_PRIME_COST_S,"+
										       "sum(F.FA_PRIME_COST_E) as FA_PRIME_COST_E,"+
										       "sum(F.FA_ACCUMULATED_DEPRECIATION_S) as FA_ACCUMULATED_DEPRECIATION_S,"+
										       "sum(F.FA_ACCUMULATED_DEPRECIATION_E) as FA_ACCUMULATED_DEPRECIATION_E,"+
										       "sum(F.FA_NET_VALUE_S) as FA_NET_VALUE_S,"+
										       "sum(F.FA_NET_VALUE_E) as FA_NET_VALUE_E,"+
										       "sum(F.FA_CONSTRUCTION_IN_PROCESS_S) as FA_CONSTRUCTION_IN_PROCESS_S,"+
										       "sum(F.FA_CONSTRUCTION_IN_PROCESS_E) as FA_CONSTRUCTION_IN_PROCESS_E,"+
										       "sum(F.FA_CULTURAL_HERITAGE_S) as FA_CULTURAL_HERITAGE_S,"+
										       "sum(F.FA_CULTURAL_HERITAGE_E) as FA_CULTURAL_HERITAGE_E,"+
										       "sum(F.FA_DISPOSAL_FIXED_ASSETS_S) as FA_DISPOSAL_FIXED_ASSETS_S,"+
										       "sum(F.FA_DISPOSAL_FIXED_ASSETS_E) as FA_DISPOSAL_FIXED_ASSETS_E,"+
										       "sum(F.FA_SUM_S) as FA_SUM_S,"+
										       "sum(F.FA_SUM_E) as FA_SUM_E,"+
										       "sum(F.PA_DEBT_S) as PA_DEBT_S,"+
										       "sum(F.PA_DEBT_E) as PA_DEBT_E,"+
										       "sum(F.PA_SUM_S) as PA_SUM_S,"+
										       "sum(F.PA_SUM_E) as PA_SUM_E,"+
										       "sum(F.INTANGIBLE_ASSETS_S) as INTANGIBLE_ASSETS_S,"+
										       "sum(F.INTANGIBLE_ASSETS_E) as INTANGIBLE_ASSETS_E,"+
										       "sum(F.ENTRUSTED_AGENT_ASSETS_S) as ENTRUSTED_AGENT_ASSETS_S,"+
										       "sum(F.ENTRUSTED_AGENT_ASSETS_E) as ENTRUSTED_AGENT_ASSETS_E,"+
										       "sum(F.ASSETS_SUM_S) as ASSETS_SUM_S,"+
										       "sum(F.ASSETS_SUM_E) as ASSETS_SUM_E,"+
										       "sum(F.UNLIMIT_NET_ASSETS_S) as UNLIMIT_NET_ASSETS_S,"+
										       "sum(F.UNLIMIT_NET_ASSETS_E) as UNLIMIT_NET_ASSETS_E,"+
										       "sum(F.LIMIT_NET_ASSETS_S) as LIMIT_NET_ASSETS_S,"+
										       "sum(F.LIMIT_NET_ASSETS_E) as LIMIT_NET_ASSETS_E,"+
										       "sum(F.NET_ASSETS_SUM_S) as NET_ASSETS_SUM_S,"+
										       "sum(F.NET_ASSETS_SUM_E) as NET_ASSETS_SUM_E,"+
										       "sum(F.DEBT_ASSETS_SUM_S) as DEBT_ASSETS_SUM_S,"+
										       "sum(F.DEBT_ASSETS_SUM_E) as DEBT_ASSETS_SUM_E "+
										 " from SOM_JX_CHECK         		T "+
										       " left join SOM_JX_PEOPLE        		A "+
										       		" on T.TASK_CODE = A.TASK_CODE "+
										       " left join SOM_JX_VIP_ORGAN     		B "+
										       		" on T.TASK_CODE = B.TASK_CODE "+
										       " left join SOM_JX_ACTIVITY      		C "+
										       		" on T.TASK_CODE = C.TASK_CODE "+
										       	 " left join SOM_JX_CHECK_PARTY   		D "+
										       		" on T.TASK_CODE = D.TASK_CODE and D.If_Build_Party='1'"+
										       " left join SOM_JX_CHECK_PARTY   		G "+
										       		" on T.TASK_CODE = G.TASK_CODE and G.If_Build_Party='0'"+
										       " left join SOM_JX_CHECK_FINANCE        E "+
										       		" on T.TASK_CODE = E.TASK_CODE "+
										       " left join SOM_JX_CHECK_BALANCE_SHEET  F "+
										       		" on T.TASK_CODE = F.TASK_CODE  where 1=1   AND T.STATUS != '0' and T.STATUS != '4'");
		
		StringBuffer sql1 = new StringBuffer("select count(T.TASK_CODE) as TOTAL"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '0'"+
										  " and T.STATUS != '4'");
		StringBuffer sql2 = new StringBuffer("select count(T.TASK_CODE) as CHECK_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'");
		StringBuffer sql3 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NO_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '4'"+
										   " and T.STATUS != '0'"+
										   " and T.STATUS != '8'");
		StringBuffer sql4 = new StringBuffer("select count(T.TASK_CODE) as CHECK_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '1'");
		StringBuffer sql5 = new StringBuffer("select count(T.TASK_CODE) as CHECK_BASAL_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '2'");
		StringBuffer sql6 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NOT_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '0'");
		if(checkYear != null && !("".equals(checkYear.trim()))){
			sql.append(" and T.CHECK_YEAR = ? ");
			sql1.append(" and T.CHECK_YEAR = ? ");
			sql2.append(" and T.CHECK_YEAR = ? ");
			sql3.append(" and T.CHECK_YEAR = ? ");
			sql4.append(" and T.CHECK_YEAR = ? ");
			sql5.append(" and T.CHECK_YEAR = ? ");
			sql6.append(" and T.CHECK_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
		}
		if(taskCodes != null && !("".equals(taskCodes.trim())) && !("null".equals(taskCodes))){
			sql.append(" AND ( ");
			sql1.append(" AND ( ");
			sql2.append(" AND ( ");
			sql3.append(" AND ( ");
			sql4.append(" AND ( ");
			sql5.append(" AND ( ");
			sql6.append(" AND ( ");
			String[] ary = taskCodes.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.TASK_CODE=? ");
				sql1.append(" T.TASK_CODE=? ");
				sql2.append(" T.TASK_CODE=? ");
				sql3.append(" T.TASK_CODE=? ");
				sql4.append(" T.TASK_CODE=? ");
				sql5.append(" T.TASK_CODE=? ");
				sql6.append(" T.TASK_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
					sql1.append(" OR ");
					sql2.append(" OR ");
					sql3.append(" OR ");
					sql4.append(" OR ");
					sql5.append(" OR ");
					sql6.append(" OR ");
				}
			}
			sql.append(" ) ");
			sql1.append(" ) ");
			sql2.append(" ) ");
			sql3.append(" ) ");
			sql4.append(" ) ");
			sql5.append(" ) ");
			sql6.append(" ) ");
		}else{
			sql.append(" AND T.SORG_TYPE = ?");
			sql1.append(" AND T.SORG_TYPE = ?");
			sql2.append(" AND T.SORG_TYPE = ?");
			sql3.append(" AND T.SORG_TYPE = ?");
			sql4.append(" AND T.SORG_TYPE = ?");
			sql5.append(" AND T.SORG_TYPE = ?");
			sql6.append(" AND T.SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add("M");
		}
		DataSet ds = new DataSet();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
			
			list = this.executeQuery(sql1.toString(), types, args);
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		} else {
			ds = this.executeDataset(sql.toString(),true);
			
			list = this.executeQuery(sql1.toString());
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString());
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString());
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString());
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString());
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString());
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		}
		for (int i = 0; i < ds.getCount(); i++) {
			Record rd = ds.getRecord(i);
			Iterator<String> it = rd.keys();
			while(it.hasNext()){
				String nextValue = it.next();
				rd.set(nextValue,rd.get(nextValue)==null?"0":rd.get(nextValue));
			}
		}
		return ds;
	}
	//##########################################         基金会年检汇报               ################################################	
	public DataSet queryFundCheckReport(ParameterSet pset){
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		String taskCodes = (String) pset.getParameter("TASK_CODE");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("select sum(T.SYNDIC_NUM) as SYNDIC_NUM,"+
											  "sum(T.INITIAL_FUND) as INITIAL_FUND,"+
										       "sum(T.AUDITOR_NUM) as AUDITOR_NUM,"+
										       "sum(T.PRINCIPAL_NUM) as PRINCIPAL_NUM,"+
										       "sum(T.PRINCIPAL_GOV_NUM) as PRINCIPAL_GOV_NUM,"+
										       "sum(T.PRINCIPAL_PROVINCE_NUM) as PRINCIPAL_PROVINCE_NUM,"+
										       "sum(T.RAMUS_NUM) as RAMUS_NUM,"+
										       "sum(T.DELEGATE_NUM) as DELEGATE_NUM,"+
										       "sum(T.FULLTIME_NUM) as FULLTIME_NUM,"+
										       "sum(T.POSTULAND_NUM) as POSTULAND_NUM,"+
										       "sum(T.POSTULAND_WORK_HOUR) as POSTULAND_WORK_HOUR,"+
										       "sum(T.SPECIAL_FUNDS) as SPECIAL_FUNDS,"+
										       "sum(DECODE(T.CHECK_RESULT,'4',1,0)) as ONE_YEAR,"+
										       "sum(DECODE(T.CHECK_RESULT,'5',1,0)) as TWO_YEAR,"+
										       
										       "sum(A.RAMUS_NUM) as RAMUS_NUM_A,"+
										       "sum(A.RAMUS_NEW_NUM) as RAMUS_NEW_NUM,"+
										       "sum(A.RAMUS_BUILDED_NUM) as RAMUS_BUILDED_NUM,"+
										       "sum(A.RAMUS_CANCEL_NUM) as RAMUS_CANCEL_NUM,"+
										       "sum(A.RAMUS_CANCELED_NUM) as RAMUS_CANCELED_NUM,"+
										       "sum(A.DELEGATE_NUM) as DELEGATE_NUM_A,"+
										       "sum(A.DELEGATE_NEW_NUM) as DELEGATE_NEW_NUM,"+
										       "sum(A.DELEGATE_BUILDED_NUM) as DELEGATE_BUILDED_NUM,"+
										       "sum(A.DELEGATE_CANCEL_NUM) as DELEGATE_CANCEL_NUM,"+
										       "sum(A.DELEGATE_CANCELED_NUM) as DELEGATE_CANCELED_NUM,"+
										       "sum(A.SPECIAL_NUM) as SPECIAL_NUM,"+
										       "sum(A.SPECIAL_NEW_NUM) as SPECIAL_NEW_NUM,"+
										       "sum(A.SPECIAL_BUILDED_NUM) as SPECIAL_BUILDED_NUM,"+
										       "sum(A.SPECIAL_CANCEL_NUM) as SPECIAL_CANCEL_NUM,"+
										       "sum(A.SPECIAL_CANCELED_NUM) as SPECIAL_CANCELED_NUM,"+
										       "sum(A.OFFICE_NUM) as OFFICE_NUM,"+
										       "sum(A.OFFICE_NEW_NUM) as OFFICE_NEW_NUM,"+
										       "sum(A.OFFICE_BUILDED_NUM) as OFFICE_BUILDED_NUM,"+
										       "sum(A.OFFICE_CANCEL_NUM) as OFFICE_CANCEL_NUM,"+
										       "sum(A.OFFICE_CANCELED_NUM) as OFFICE_CANCELED_NUM,"+
										       "sum(A.ENTITY_NUM) as ENTITY_NUM,"+
										       "sum(A.ENTITY_NEW_NUM) as ENTITY_NEW_NUM,"+
										       "sum(A.ENTITY_BUILDED_NUM) as ENTITY_BUILDED_NUM,"+
										       "sum(A.ENTITY_CANCEL_NUM) as ENTITY_CANCEL_NUM,"+
										       "sum(A.ENTITY_CANCELED_NUM) as ENTITY_CANCELED_NUM,"+
										       
										       // TODO 党建
										       "sum(DECODE(D.IF_BUILD_PARTY,'1',1,0)) as IF_BUILD_PARTY1,"+
										       "sum(D.PARTY_WORKER_NUM) as PARTY_WORKER_NUM,"+
										       "sum(DECODE(D.PARTY_TYPE,'1',1,0)) as PARTY_TYPE1,"+
										       "sum(DECODE(D.PARTY_TYPE,'2',1,0)) as PARTY_TYPE2,"+
										       "sum(DECODE(D.PARTY_TYPE,'3',1,0)) as PARTY_TYPE3,"+
										       "sum(DECODE(D.PARTY_TYPE,'4',1,0)) as PARTY_TYPE4,"+
										       "sum(DECODE(D.PARTY_TYPE,'5',1,0)) as PARTY_TYPE5,"+
										       "sum(DECODE(D.PARTY_TYPE,'6',1,0)) as PARTY_TYPE6,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'1',1,0)) as PARTY_RELATION_TYPE1,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'2',1,0)) as PARTY_RELATION_TYPE2,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'3',1,0)) as PARTY_RELATION_TYPE3,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'4',1,0)) as PARTY_RELATION_TYPE4,"+
										       "sum(DECODE(D.PARTY_RELATION_TYPE,'5',1,0)) as PARTY_RELATION_TYPE5,"+
										       "sum(DECODE(D.PARTY_SPACE,'1',1,0)) as PARTY_SPACE1,"+
										       "sum(DECODE(D.PARTY_SPACE,'2',1,0)) as PARTY_SPACE2,"+
										       "sum(DECODE(D.PARTY_SPACE,'3',1,0)) as PARTY_SPACE3,"+
										       "sum(DECODE(D.PARTY_SPACE,'4',1,0)) as PARTY_SPACE4,"+
										       "sum(DECODE(D.PARTY_SPACE,'5',1,0)) as PARTY_SPACE5,"+
										       "sum(D.PARTY_ACTIVITY_MON) as PARTY_ACTIVITY_MON,"+
										       "sum(D.PARTY_DUES_MON) as PARTY_DUES_MON,"+
										       "sum(D.PARTY_SUPPORT_MON) as PARTY_SUPPORT_MON,"+
										       "sum(D.PARTY_BUSINESS_MON) as PARTY_BUSINESS_MON,"+
										       "sum(D.PARTY_FINANCE_MON) as PARTY_FINANCE_MON,"+
										       "sum(D.PARTY_OTHER_MON) as PARTY_OTHER_MON,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'1',1,0)) as PARTY_PEOPLE_TYPE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'2',1,0)) as PARTY_PEOPLE_TYPE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_TYPE,'3',1,0)) as PARTY_PEOPLE_TYPE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'1',1,0)) as PARTY_PEOPLE_AGE1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'2',1,0)) as PARTY_PEOPLE_AGE2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'3',1,0)) as PARTY_PEOPLE_AGE3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_AGE,'4',1,0)) as PARTY_PEOPLE_AGE4,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'1',1,0)) as PARTY_PEOPLE_EDU1,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'2',1,0)) as PARTY_PEOPLE_EDU2,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'3',1,0)) as PARTY_PEOPLE_EDU3,"+
										       "sum(DECODE(D.PARTY_PEOPLE_EDU,'4',1,0)) as PARTY_PEOPLE_EDU4,"+
										       "sum(D.PARTY_MEMBER_TOTAL) as PARTY_MEMBER_TOTAL,"+
										       "sum(D.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM,"+
										       "sum(D.LEGAL_PARTY_NUM) as LEGAL_PARTY_NUM,"+
										       "sum(D.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM,"+
										       "sum(D.PARTY_MASTER_NUM) as PARTY_MASTER_NUM,"+
										       "sum(D.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM,"+
										       "sum(D.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM,"+
										       "sum(D.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM,"+
										       "sum(D.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM,"+
										       "sum(D.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM,"+
										       "sum(D.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM,"+
										       "sum(D.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM,"+
										       "sum(D.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_SELF,'1',1,0)) as PARTY_STUDY_WAY_SELF1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_TALK,'1',1,0)) as PARTY_STUDY_WAY_TALK1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_CHAIR,'1',1,0)) as PARTY_STUDY_WAY_CHAIR1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_VISIT,'1',1,0)) as PARTY_STUDY_WAY_VISIT1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_ART,'1',1,0)) as PARTY_STUDY_WAY_ART1,"+
										       "sum(DECODE(D.PARTY_STUDY_WAY_OTHER,'1',1,0)) as PARTY_STUDY_WAY_OTHER1,"+
										       "sum(D.PARTY_PARTY_NUM) as PARTY_PARTY_NUM,"+
										       "sum(D.PARTY_BORG_NUM) as PARTY_BORG_NUM,"+
										       "sum(D.PARTY_LINKED_NUM) as PARTY_LINKED_NUM,"+
										       "sum(D.PARTY_COLONY_NUM) as PARTY_COLONY_NUM,"+
										       "sum(D.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM,"+
										       "sum(D.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM,"+
										       "sum(D.PARTY_ACTIVITY_NUM) as PARTY_ACTIVITY_NUM,"+
										       "sum(D.ACTIVITY_GOOD_NUM) as ACTIVITY_GOOD_NUM,"+
										       
										       "sum(DECODE(G.IF_BUILD_PARTY,'0',1,0)) as IF_BUILD_PARTY0,"+
										       "sum(DECODE(G.IF_PARTY_OFFICER,'1',1,0)) as IF_PARTY_OFFICER1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'1',1,0)) as NO_BUILD_PARTY_RESON1,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'2',1,0)) as NO_BUILD_PARTY_RESON2,"+
										       "sum(DECODE(G.NO_BUILD_PARTY_RESON,'3',1,0)) as NO_BUILD_PARTY_RESON3,"+
										       "sum(G.PARTY_PRACTITIONER_NUM) as PARTY_PRACTITIONER_NUM_A,"+
										       "sum(G.PARTY_UNDER_THIRTY_FIVE_NUM) as PARTY_UNDER_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_ABROAD_NUM) as PARTY_ABROAD_NUM_A,"+
										       "sum(G.PARTY_FULL_TIME_NUM) as PARTY_FULL_TIME_NUM_A,"+
										       "sum(G.PARTY_ABOVE_THIRTY_FIVE_NUM) as PARTY_ABOVE_THIRTY_FIVE_NUM_A,"+
										       "sum(G.PARTY_MASTER_NUM) as PARTY_MASTER_NUM_A,"+
										       "sum(G.PARTY_RETIRE_NUM) as PARTY_RETIRE_NUM_A,"+
										       "sum(G.PARTY_UNDER_SIXTY_NUM) as PARTY_UNDER_SIXTY_NUM_A,"+
										       "sum(G.PARTY_BACHELOR_NUM) as PARTY_BACHELOR_NUM_A,"+
										       "sum(G.NEW_PARTY_PEOPLE_NUM) as NEW_PARTY_PEOPLE_NUM_A,"+
										       "sum(G.PARTY_ABOVE_SIXTY_NUM) as PARTY_ABOVE_SIXTY_NUM_A,"+
										       "sum(G.PARTY_SENIOR_NUM) as PARTY_SENIOR_NUM_A,"+
										       "sum(G.PARTY_BORG_NUM) as PARTY_BORG_NUM_A,"+
										       "sum(G.PARTY_LINKED_NUM) as PARTY_LINKED_NUM_A,"+
										       "sum(G.PARTY_COLONY_NUM) as PARTY_COLONY_NUM_A,"+
										       "sum(G.PARTY_WORK_SPACE_NUM) as PARTY_WORK_SPACE_NUM_A,"+
										       "sum(G.PARTY_OTHER_SUBJECTION_NUM) as PARTY_OTHER_SUBJECTION_NUM_A,"+
										       
										       "sum(C.COMM_LAST_SUM) as COMM_LAST_SUM,"+
										       "sum(C.COMM_LAST_TOTAL) as COMM_LAST_TOTAL,"+
										       "sum(C.COMM_EXPENDITURE) as COMM_EXPENDITURE,"+
										       "sum(C.COMM_EXP_PUB) as COMM_EXP_PUB,"+
										       "sum(C.COMM_EXP_PER) as COMM_EXP_PER,"+
										       "sum(C.COMM_EXP_OFF) as COMM_EXP_OFF,"+
										       "sum(C.EXPENDITURE) as EXPENDITURE,"+
										       "sum(C.EXP_PUB) as EXP_PUB,"+
										       "sum(C.EXP_PER) as EXP_PER,"+
										       "sum(C.EXP_OFF) as EXP_OFF,"+
										       "sum(C.BALANCE) as BALANCE,"+
										       
										       "sum(P.ABOVE_COUNTY_NUM) as ABOVE_COUNTY_NUM,"+
										       "sum(P.PARTY_NUM_PROVINCE) as PARTY_NUM_PROVINCE,"+
										       "sum(P.PARTY_NUM_NATION) as PARTY_NUM_NATION,"+
										       "sum(P.NPC_NUM) as NPC_NUM,"+
										       "sum(P.NPC_NUM_PROVINCE) as NPC_NUM_PROVINCE,"+
										       "sum(P.NPC_NUM_NATION) as NPC_NUM_NATION,"+
										       "sum(P.CPPCC_NUM) as CPPCC_NUM,"+
										       "sum(P.CPPCC_NUM_PROVINCE) as CPPCC_NUM_PROVINCE,"+
										       "sum(P.CPPCC_NUM_NATION) as CPPCC_NUM_NATION,"+
										       
										       "sum(E.CA_MONEYFUNDS_S) as CA_MONEYFUNDS_S,"+
										       "sum(E.CA_LIQUID_INVESTMENT_S) as CA_LIQUID_INVESTMENT_S,"+
										       "sum(E.CA_MONEYFUNDS_E) as CA_MONEYFUNDS_E,"+
										       "sum(E.CA_LIQUID_INVESTMENT_E) as CA_LIQUID_INVESTMENT_E,"+
										       "sum(E.CA_RECEIVABLES_S) as CA_RECEIVABLES_S,"+
										       "sum(E.CA_RECEIVABLES_E) as CA_RECEIVABLES_E,"+
										       "sum(E.CA_ADVANCE_MONEY_S) as CA_ADVANCE_MONEY_S,"+
										       "sum(E.CA_ADVANCE_MONEY_E) as CA_ADVANCE_MONEY_E,"+
										       "sum(E.CA_INVENTORY_S) as CA_INVENTORY_S,"+
										       "sum(E.CA_INVENTORY_E) as CA_INVENTORY_E,"+
										       "sum(E.CA_DEFERRED_EXPENSES_S) as CA_DEFERRED_EXPENSES_S,"+
										       "sum(E.CA_DEFERRED_EXPENSES_E) as CA_DEFERRED_EXPENSES_E,"+
										       "sum(E.CA_DEBT_INVESTMENTS_S) as CA_DEBT_INVESTMENTS_S,"+
										       "sum(E.CA_DEBT_INVESTMENTS_E) as CA_DEBT_INVESTMENTS_E,"+
										       "sum(E.CA_OTHERS_S) as CA_OTHERS_S,"+
										       "sum(E.CA_SUM_S) as CA_SUM_S,"+
										       "sum(E.CL_SHORTTERM_BORROWING_S) as CL_SHORTTERM_BORROWING_S,"+
										       "sum(E.CL_SHORTTERM_BORROWING_E) as CL_SHORTTERM_BORROWING_E,"+
										       "sum(E.CL_DUES_S) as CL_DUES_S,"+
										       "sum(E.CL_DUES_E) as CL_DUES_E,"+
										       "sum(E.CL_ACCRUED_PAYROLLS_S) as CL_ACCRUED_PAYROLLS_S,"+
										       "sum(E.CL_ACCRUED_PAYROLLS_E) as CL_ACCRUED_PAYROLLS_E,"+
										       "sum(E.CL_TAS_PAYABLE_S) as CL_TAS_PAYABLE_S,"+
										       "sum(E.CL_TAS_PAYABLE_E) as CL_TAS_PAYABLE_E,"+
										       "sum(E.CL_DEPOSIT_RECEIVED_S) as CL_DEPOSIT_RECEIVED_S,"+
										       "sum(E.CL_DEPOSIT_RECEIVED_E) as CL_DEPOSIT_RECEIVED_E,"+
										       "sum(E.CL_ACCRUED_EXPENSES_S) as CL_ACCRUED_EXPENSES_S,"+
										       "sum(E.CL_ACCRUED_EXPENSES_E) as CL_ACCRUED_EXPENSES_E,"+
										       "sum(E.CL_ACCRUED_LIABILITIES_S) as CL_ACCRUED_LIABILITIES_S,"+
										       "sum(E.CL_ACCRUED_LIABILITIES_E) as CL_ACCRUED_LIABILITIES_E,"+
										       "sum(E.CL_LONGTERM_DUE_S) as CL_LONGTERM_DUE_S,"+
										       "sum(E.CL_LONGTERM_DUE_E) as CL_LONGTERM_DUE_E,"+
										       "sum(E.CL_OTHERS_S) as CL_OTHERS_S,"+
										       "sum(E.CA_OTHERS_E) as CA_OTHERS_E,"+
										       "sum(E.CA_SUM_E) as CA_SUM_E,"+
										       "sum(E.CL_OTHERS_E) as CL_OTHERS_E,"+
										       "sum(E.CL_SUM_S) as CL_SUM_S,"+
										       "sum(E.CL_SUM_E) as CL_SUM_E,"+
										       "sum(E.PI_LONGTERM_EQUITY_INV_S) as PI_LONGTERM_EQUITY_INV_S,"+
										       "sum(E.PI_LONGTERM_EQUITY_INV_E) as PI_LONGTERM_EQUITY_INV_E,"+
										       "sum(E.PI_LONGTERM_DEBT_INV_S) as PI_LONGTERM_DEBT_INV_S,"+
										       "sum(E.PI_LONGTERM_DEBT_INV_E) as PI_LONGTERM_DEBT_INV_E,"+
										       "sum(E.PI_SUM_S) as PI_SUM_S,"+
										       "sum(E.PI_SUM_E) as PI_SUM_E,"+
										       "sum(E.LL_LONGTERM_LOANS_S) as LL_LONGTERM_LOANS_S,"+
										       "sum(E.LL_LONGTERM_LOANS_E) as LL_LONGTERM_LOANS_E,"+
										       "sum(E.LL_LONGTERM_PAYABLE_S) as LL_LONGTERM_PAYABLE_S,"+
										       "sum(E.LL_LONGTERM_PAYABLE_E) as LL_LONGTERM_PAYABLE_E,"+
										       "sum(E.LL_OTHERS_S) as LL_OTHERS_S,"+
										       "sum(E.LL_OTHERS_E) as LL_OTHERS_E,"+
										       "sum(E.LL_SUM_S) as LL_SUM_S,"+
										       "sum(E.LL_SUM_E) as LL_SUM_E,"+
										       "sum(E.FA_PRIME_COST_S) as FA_PRIME_COST_S,"+
										       "sum(E.FA_PRIME_COST_E) as FA_PRIME_COST_E,"+
										       "sum(E.FA_ACCUMULATED_DEPRECIATION_S) as FA_ACCUMULATED_DEPRECIATION_S,"+
										       "sum(E.FA_ACCUMULATED_DEPRECIATION_E) as FA_ACCUMULATED_DEPRECIATION_E,"+
										       "sum(E.FA_NET_VALUE_S) as FA_NET_VALUE_S,"+
										       "sum(E.FA_NET_VALUE_E) as FA_NET_VALUE_E,"+
										       "sum(E.FA_CONSTRUCTION_IN_PROCESS_S) as FA_CONSTRUCTION_IN_PROCESS_S,"+
										       "sum(E.FA_CONSTRUCTION_IN_PROCESS_E) as FA_CONSTRUCTION_IN_PROCESS_E,"+
										       "sum(E.FA_CULTURAL_HERITAGE_S) as FA_CULTURAL_HERITAGE_S,"+
										       "sum(E.FA_CULTURAL_HERITAGE_E) as FA_CULTURAL_HERITAGE_E,"+
										       "sum(E.FA_DISPOSAL_FIXED_ASSETS_S) as FA_DISPOSAL_FIXED_ASSETS_S,"+
										       "sum(E.FA_DISPOSAL_FIXED_ASSETS_E) as FA_DISPOSAL_FIXED_ASSETS_E,"+
										       "sum(E.FA_SUM_S) as FA_SUM_S,"+
										       "sum(E.FA_SUM_E) as FA_SUM_E,"+
										       "sum(E.PA_DEBT_S) as PA_DEBT_S,"+
										       "sum(E.PA_DEBT_E) as PA_DEBT_E,"+
										       "sum(E.PA_SUM_S) as PA_SUM_S,"+
										       "sum(E.PA_SUM_E) as PA_SUM_E,"+
										       "sum(E.INTANGIBLE_ASSETS_S) as INTANGIBLE_ASSETS_S,"+
										       "sum(E.INTANGIBLE_ASSETS_E) as INTANGIBLE_ASSETS_E,"+
										       "sum(E.ENTRUSTED_AGENT_ASSETS_S) as ENTRUSTED_AGENT_ASSETS_S,"+
										       "sum(E.ENTRUSTED_AGENT_ASSETS_E) as ENTRUSTED_AGENT_ASSETS_E,"+
										       "sum(E.ASSETS_SUM_S) as ASSETS_SUM_S,"+
										       "sum(E.ASSETS_SUM_E) as ASSETS_SUM_E,"+
										       "sum(E.UNLIMIT_NET_ASSETS_S) as UNLIMIT_NET_ASSETS_S,"+
										       "sum(E.UNLIMIT_NET_ASSETS_E) as UNLIMIT_NET_ASSETS_E,"+
										       "sum(E.LIMIT_NET_ASSETS_S) as LIMIT_NET_ASSETS_S,"+
										       "sum(E.LIMIT_NET_ASSETS_E) as LIMIT_NET_ASSETS_E,"+
										       "sum(E.NET_ASSETS_SUM_S) as NET_ASSETS_SUM_S,"+
										       "sum(E.NET_ASSETS_SUM_E) as NET_ASSETS_SUM_E,"+
										       "sum(E.DEBT_ASSETS_SUM_S) as DEBT_ASSETS_SUM_S,"+
										       "sum(E.DEBT_ASSETS_SUM_E) as DEBT_ASSETS_SUM_E "+
										 " from SOM_JX_CHECK         		T "+
										 
										    " left join SOM_JX_ORGAN_BASIC   		A "+
										    	" on T.TASK_CODE = A.TASK_CODE "+
										    " left join SOM_JX_CHECK_EXPENDITURE    		C "+
										    	" on T.TASK_CODE = C.TASK_CODE "+
										    " left join SOM_JX_CHECK_PARTY   		D"+
									       		" on T.TASK_CODE = D.TASK_CODE and D.If_Build_Party='1'"+
									       	" left join SOM_JX_CHECK_PARTY   		G"+
									       		" on T.TASK_CODE = G.TASK_CODE and G.If_Build_Party='0'"+
									       	 " left join SOM_JX_PEOPLE        		P "+
									       		" on T.TASK_CODE = P.TASK_CODE "+   
										    " left join SOM_JX_CHECK_BALANCE_SHEET  E "+
										    	" on T.TASK_CODE = E.TASK_CODE  where 1=1  AND T.STATUS != '0' and T.STATUS != '4'");
		
		
		StringBuffer _sql = new StringBuffer("select sum(DECODE(B.IF_OPEN,'0',B.CURRENT_TOTAL,0) ) as CURRENT_TOTAL,"+
										       "sum(DECODE(B.IF_OPEN,'0',B.IN_TOTAL,0) ) as IN_TOTAL,"+
										       "sum(DECODE(B.IF_OPEN,'0',B.OFF_TOTAL,0) ) as OFF_TOTAL,"+
										       "sum(DECODE(B.IF_OPEN,'1',B.ITEM_NUM,0) ) as ITEM_NUM,"+
										       "sum(DECODE(B.IF_OPEN,'1',B.CURRENT_TOTAL,0) ) as CURRENT_TOTAL1,"+
										       "sum(DECODE(B.IF_OPEN,'1',B.IN_TOTAL,0) ) as IN_TOTAL1,"+
										       "sum(DECODE(B.IF_OPEN,'1',B.OFF_TOTAL,0) ) as OFF_TOTAL1,"+
										       "sum(DECODE(B.IF_OPEN,'2',B.CURRENT_TOTAL,0) ) as CURRENT_TOTAL2,"+
										       "sum(DECODE(B.IF_OPEN,'2',B.IN_TOTAL,0) ) as IN_TOTAL2,"+
										       "sum(DECODE(B.IF_OPEN,'2',B.OFF_TOTAL,0) ) as OFF_TOTAL2 "+
										 " from SOM_JX_CHECK         		T,"+
										       "SOM_JX_CONTRIBUTE   		B "+
										" where T.TASK_CODE=B.TASK_CODE(+)");
		StringBuffer sql1 = new StringBuffer("select count(T.TASK_CODE) as TOTAL"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '0'"+
										  " and T.STATUS != '4'");
		StringBuffer sql2 = new StringBuffer("select count(T.TASK_CODE) as CHECK_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'");
		StringBuffer sql3 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NO_PASS"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS != '4'"+
										   " and T.STATUS != '0'"+
										   " and T.STATUS != '8'");
		StringBuffer sql4 = new StringBuffer("select count(T.TASK_CODE) as CHECK_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '1'");
		StringBuffer sql5 = new StringBuffer("select count(T.TASK_CODE) as CHECK_BASAL_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '2'");
		StringBuffer sql6 = new StringBuffer("select count(T.TASK_CODE) as CHECK_NOT_OK"+
										 " from SOM_JX_CHECK T"+
										 " where T.STATUS = '8'"+
										   " and T.CHECK_RESULT = '0'");
		if(checkYear != null && !("".equals(checkYear.trim()))){
			sql.append(" and T.CHECK_YEAR = ? ");
			_sql.append(" and T.CHECK_YEAR = ? ");
			sql1.append(" and T.CHECK_YEAR = ? ");
			sql2.append(" and T.CHECK_YEAR = ? ");
			sql3.append(" and T.CHECK_YEAR = ? ");
			sql4.append(" and T.CHECK_YEAR = ? ");
			sql5.append(" and T.CHECK_YEAR = ? ");
			sql6.append(" and T.CHECK_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
		}
		if(taskCodes != null && !("".equals(taskCodes.trim())) && !("null".equals(taskCodes))){
			sql.append(" AND ( ");
			_sql.append(" AND ( ");
			sql1.append(" AND ( ");
			sql2.append(" AND ( ");
			sql3.append(" AND ( ");
			sql4.append(" AND ( ");
			sql5.append(" AND ( ");
			sql6.append(" AND ( ");
			String[] ary = taskCodes.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.TASK_CODE=? ");
				_sql.append(" T.TASK_CODE=? ");
				sql1.append(" T.TASK_CODE=? ");
				sql2.append(" T.TASK_CODE=? ");
				sql3.append(" T.TASK_CODE=? ");
				sql4.append(" T.TASK_CODE=? ");
				sql5.append(" T.TASK_CODE=? ");
				sql6.append(" T.TASK_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
					_sql.append(" OR ");
					sql1.append(" OR ");
					sql2.append(" OR ");
					sql3.append(" OR ");
					sql4.append(" OR ");
					sql5.append(" OR ");
					sql6.append(" OR ");
				}
			}
			sql.append(" ) ");
			_sql.append(" ) ");
			sql1.append(" ) ");
			sql2.append(" ) ");
			sql3.append(" ) ");
			sql4.append(" ) ");
			sql5.append(" ) ");
			sql6.append(" ) ");
		}else{
			sql.append(" AND T.SORG_TYPE = ?");
			_sql.append(" AND T.SORG_TYPE = ?");
			sql1.append(" AND T.SORG_TYPE = ?");
			sql2.append(" AND T.SORG_TYPE = ?");
			sql3.append(" AND T.SORG_TYPE = ?");
			sql4.append(" AND T.SORG_TYPE = ?");
			sql5.append(" AND T.SORG_TYPE = ?");
			sql6.append(" AND T.SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add("J");
		}
		DataSet ds = new DataSet();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
			
			list = this.executeQuery(_sql.toString(), types, args);
			if(list.size()>0){
				ds.addField("CURRENT_TOTAL");
				ds.getRecord(0).set("CURRENT_TOTAL", list.get(0).get("CURRENT_TOTAL"));
				ds.addField("IN_TOTAL");
				ds.getRecord(0).set("IN_TOTAL", list.get(0).get("IN_TOTAL"));
				ds.addField("OFF_TOTAL");
				ds.getRecord(0).set("OFF_TOTAL", list.get(0).get("OFF_TOTAL"));
				
				ds.addField("ITEM_NUM");
				ds.getRecord(0).set("ITEM_NUM", list.get(0).get("ITEM_NUM"));
				ds.addField("CURRENT_TOTAL1");
				ds.getRecord(0).set("CURRENT_TOTAL1", list.get(0).get("CURRENT_TOTAL1"));
				ds.addField("IN_TOTAL1");
				ds.getRecord(0).set("IN_TOTAL1", list.get(0).get("IN_TOTAL1"));
				ds.addField("OFF_TOTAL1");
				ds.getRecord(0).set("OFF_TOTAL1", list.get(0).get("OFF_TOTAL1"));
				
				ds.addField("CURRENT_TOTAL2");
				ds.getRecord(0).set("CURRENT_TOTAL2", list.get(0).get("CURRENT_TOTAL2"));
				ds.addField("IN_TOTAL2");
				ds.getRecord(0).set("IN_TOTAL2", list.get(0).get("IN_TOTAL2"));
				ds.addField("OFF_TOTAL2");
				ds.getRecord(0).set("OFF_TOTAL2", list.get(0).get("OFF_TOTAL2"));
			}
			
			list.clear();
			list = this.executeQuery(sql1.toString(), types, args);
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString(), types, args);
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		} else {
			ds = this.executeDataset(sql.toString(),true);
			
			list = this.executeQuery(sql1.toString());
			if(list.size()>0){
				ds.addField("TOTAL");
				ds.getRecord(0).set("TOTAL", list.get(0).get("TOTAL"));
			}
			list.clear();
			list = this.executeQuery(sql2.toString());
			if(list.size()>0){
				ds.addField("CHECK_PASS");
				ds.getRecord(0).set("CHECK_PASS", list.get(0).get("CHECK_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql3.toString());
			if(list.size()>0){
				ds.addField("CHECK_NO_PASS");
				ds.getRecord(0).set("CHECK_NO_PASS", list.get(0).get("CHECK_NO_PASS"));
			}
			list.clear();
			list = this.executeQuery(sql4.toString());
			if(list.size()>0){
				ds.addField("CHECK_OK");
				ds.getRecord(0).set("CHECK_OK", list.get(0).get("CHECK_OK"));
			}
			list.clear();
			list = this.executeQuery(sql5.toString());
			if(list.size()>0){
				ds.addField("CHECK_BASAL_OK");
				ds.getRecord(0).set("CHECK_BASAL_OK", list.get(0).get("CHECK_BASAL_OK"));
			}
			list.clear();
			list = this.executeQuery(sql6.toString());
			if(list.size()>0){
				ds.addField("CHECK_NOT_OK");
				ds.getRecord(0).set("CHECK_NOT_OK", list.get(0).get("CHECK_NOT_OK"));
			}
		}
		for (int i = 0; i < ds.getCount(); i++) {
			Record rd = ds.getRecord(i);
			Iterator<String> it = rd.keys();
			while(it.hasNext()){
				String nextValue = it.next();
				rd.set(nextValue,rd.get(nextValue)==null?"0":rd.get(nextValue));
			}
		}
		return ds;
	}
	//##########################################         年检汇报基本数据分析               ################################################	
	public DataSet queryCheckBaseAnalyse(ParameterSet pset){
		StringBuffer sql = new StringBuffer("select CN_NAME,SORG_CODE,SORG_KIND from SOM_JX_CHECK where 1=1");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		String taskCodes = (String) pset.getParameter("TASK_CODE");
		String sorgType = (String) pset.getParameter("SORG_TYPE");
		String item = (String) pset.getParameter("ITEM");
		if(checkYear != null && !("".equals(checkYear.trim()))){
			sql.append(" and CHECK_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
		}
		if(taskCodes != null && !("".equals(taskCodes.trim())) && !("null".equals(taskCodes))){
			sql.append(" and ( ");
			String[] ary = taskCodes.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" TASK_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		if(sorgType!=null && !("".endsWith(sorgType))){
			sql.append(" and SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(item!=null && !("".endsWith(item))){
			if(item.endsWith("1")){
				sql.append(" and STATUS != ? and STATUS != ?");
				typeList.add(Types.VARCHAR);
				objsList.add("0");
				typeList.add(Types.VARCHAR);
				objsList.add("4");
			}
			if(item.endsWith("2")){
				sql.append(" and STATUS = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("8");
			}
			if(item.endsWith("3")){
				sql.append(" and STATUS != ? and STATUS != ? and STATUS != ?");
				typeList.add(Types.VARCHAR);
				objsList.add("0");
				typeList.add(Types.VARCHAR);
				objsList.add("4");
				typeList.add(Types.VARCHAR);
				objsList.add("8");
			}
			if(item.endsWith("4")){
				sql.append(" and STATUS = ? and CHECK_RESULT = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("8");
				typeList.add(Types.VARCHAR);
				objsList.add("1");
			}
			if(item.endsWith("5")){
				sql.append(" and STATUS = ? and CHECK_RESULT = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("8");
				typeList.add(Types.VARCHAR);
				objsList.add("2");
			}
			if(item.endsWith("6")){
				sql.append(" and STATUS = ? and CHECK_RESULT = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("8");
				typeList.add(Types.VARCHAR);
				objsList.add("0");
			}
			if(item.endsWith("7")){
				sql.append(" and CHECK_RESULT = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("4");
			}
			if(item.endsWith("8")){
				sql.append(" and CHECK_RESULT = ?");
				typeList.add(Types.VARCHAR);
				objsList.add("5");
			}
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
	}
	//##########################################         年检汇报常用数据分析               ################################################	
	public DataSet queryCheckAnalyse(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		String taskCodes = (String) pset.getParameter("TASK_CODE");
		String sorgType = (String) pset.getParameter("SORG_TYPE");
		String tableName = (String) pset.getParameter("TABLE_NAME");
		String fieldName = (String) pset.getParameter("FIELD");
		String ifOpen = (String) pset.getParameter("IF_OPEN");
		
		String sqlfield= (String) pset.getParameter("sqlfield");
		String ifBuildParty= (String) pset.getParameter("ifBuildParty");
//		String partyType = (String) pset.getParameter("PARTY_TYPE");
//		String partyRelationType = (String) pset.getParameter("PARTY_RELATION_TYPE");
//		String reason = (String) pset.getParameter("REASON");
//		String officerType = (String) pset.getParameter("OFFICER_TYPE");
//		String partyPeopleType = (String) pset.getParameter("PARTY_PEOPLE_TYPE");
//		String officer = (String) pset.getParameter("OFFICER");
		StringBuffer sql = new StringBuffer("");
		if(tableName!=null && !("".endsWith(tableName)) && fieldName!=null && !("".endsWith(fieldName))){
			sql.append("select T.CN_NAME,T.SORG_CODE,T.SORG_KIND,X."+fieldName+" from SOM_JX_CHECK T,"+tableName+" X where T.STATUS!='0' AND  T.STATUS!='4' AND T.TASK_CODE=X.TASK_CODE and X."+fieldName+" is not null");
		}else{
			return null;
		}
		if(checkYear != null && !("".equals(checkYear.trim()))){
			sql.append(" and T.CHECK_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkYear);
		}
		if(taskCodes != null && !("".equals(taskCodes.trim())) && !("null".equals(taskCodes))){
			sql.append(" and ( ");
			String[] ary = taskCodes.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.TASK_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		if(sorgType!=null && !("".endsWith(sorgType))){
			sql.append(" and T.SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(ifOpen!=null && !("".endsWith(ifOpen))){
			sql.append(" and X.IF_OPEN = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(ifOpen);
		}
		if(sqlfield!=null && !("".endsWith(sqlfield))){
			sql.append(" and X."+fieldName);
					sql.append		("  = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sqlfield);
		}
		
		if("SOM_JX_CHECK_PARTY".endsWith(tableName) && !"IF_BUILD_PARTY".endsWith(fieldName)){
			if(ifBuildParty!=null && !("".endsWith(ifBuildParty)) ){
				sql.append(" and X.if_Build_Party = '0'");
			}else{
				sql.append(" and X.if_Build_Party = '1'");
			}
		}
		sql.append(" ORDER BY TO_NUMBER(X."+fieldName+") DESC ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
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
	 * 查询年检数据是否全部填写,以控制上报
	 * @param taskCode 业务主键
	 * @param sorgType 社会组织类型
	 * @return flag
	 */
	public String queryForReport(String taskCode,String sorgType) {
		StringBuffer flag = new StringBuffer();
		flag.append("第");
		DataSet ds = new DataSet();
		boolean b=false;
		for(int i=1;i<30;i++){
			String properties=JxCheckProperties.getString(sorgType+i);
			if(properties != null){
				StringBuffer sql = new StringBuffer("select count(*) as num from ");
				sql.append(properties);
				sql.append(" and task_code=?");
				int[] types = new int[] { Types.VARCHAR };
				Object[] args = new Object[] { taskCode };
				ds = executeDataset(sql.toString(), types, args, true);
				if("0".equals(ds.getRecord(0).get("NUM").toString())){
					flag.append(i);
					flag.append(" ");
					b=true;
				}
			}
		}
		flag.append("页数据未进行填写！");
		if(b){
			return flag.toString();
		}else{
			return "true";
		}
		
	}
}
