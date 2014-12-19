package com.inspur.sdmz.jzfa.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.jzfa.dao.IPlanDao;
import com.inspur.sdmz.jzfa.data.Detail;
import com.inspur.sdmz.jzfa.data.Plan;

/**
 * 救助方案Dao实现类
 * @author shgtch
 * @date 2011-4-16
 */
public class PlanDao extends EntityDao<Plan> implements IPlanDao {

	@Override
	protected Class getEntityClass() {
		return Plan.class;
	}
	private static final Log logger = LogFactory.getLog(PlanDao.class);
	
	/**
	 * 增加一条救助方案
	 * @param jzfa
	 */
	public void addJzfa(Plan jzfa) {
		this.insert(jzfa);
	}
	
	/**
	 * 修改一条救助方案
	 * @param jzfa
	 */
	public void updateJzfa(Plan jzfa) {
		this.update(jzfa);
	}
	
	/**
	 * 删除一条救助方案
	 * @param jzfaid
	 */
	public void deleteJzfa(String jzfaid) {
		this.delete(jzfaid);
	}
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfaQuery(ParameterSet pset) {
		return this.query(pset);
	}
	
	/**
	 * 外部单位查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet queryExt(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		sql.append("SELECT SAM_PLAN.PLAN_ORGAN_ID,SAM_PLAN.PLAN_ID,SAM_PLAN.PLAN_BEGIN,");
		sql.append("SAM_PLAN.REG_ORGAN_TYPE,SAM_PLAN.REG_ID,SAM_PLAN.MOD_ID,SAM_PLAN.PLAN_NAME,");
		sql.append("SAM_PLAN.MOD_ORGAN_REGION,SAM_PLAN.MOD_NAME,SAM_PLAN.MOD_DATE,SAM_PLAN.MOD_ORGAN_ID,");
		sql.append("SAM_PLAN.REG_NAME,SAM_PLAN.REG_TIME,SAM_PLAN.PLAN_ORGAN_REGION,SAM_PLAN.REG_ORGAN_NAME,");
		sql.append("SAM_PLAN.FUND,SAM_PLAN.PLAN_ORGAN_NAME,SAM_PLAN.STATUS,SAM_PLAN.REG_ORGAN_ID,");
		sql.append("SAM_PLAN.PLAN_TYPE,SAM_PLAN.MOD_ORGAN_NAME,SAM_PLAN.PLAN_END,SAM_PLAN.REG_ORGAN_REGION,");
		sql.append("SAM_PLAN.PEOPLE_NUM,SAM_PLAN.FAMILY_NUM ");
		sql.append("FROM SAM_PLAN,com_plan_organ WHERE 1 = 1");
		sql.append("and SAM_PLAN.PLAN_ID=com_plan_organ.plan_id ");
		
		String planOrgReg = (String) pset.getParameter("PLAN_ORGAN_REGION");//根据当前登录单位的行政区划过滤查询条件
		String orgType = (String) pset.getParameter("ORGAN_TYPE");//根据各登录单位类型过滤查询条件
		String jzfamc = (String) pset.getParameter("PLAN_NAME");//救助方案名称
		String jzlxdm = (String) pset.getParameter("PLAN_TYPE");//救助类型
		String jzrqQs = (String) pset.getParameter("PLAN_BEGIN");//救助开始时间S
		String jzrqQt = (String) pset.getParameter("PLAN_END");//救助开始时间T
		String lrsjs = (String) pset.getParameter("REG_TIMES");//录入时间S
		String lrsjt = (String) pset.getParameter("REG_TIMET");//录入时间T
		String status = (String) pset.getParameter("STATUS");//状态
		
		//查询条件
		if (planOrgReg != null && !planOrgReg.equals("")) {//救助单位区划
			sql.append(" and SAM_PLAN.PLAN_ORGAN_REGION LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			argsList.add(planOrgReg);
		}
		if (orgType != null && !orgType.equals("")) {//救助单位类型
			sql.append(" and COM_PLAN_ORGAN.ORGAN_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(orgType);
		}
		if (jzfamc != null && !jzfamc.equals("")) {
			sql.append(" and SAM_PLAN.PLAN_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(jzfamc);
		}
		if (jzlxdm != null && !jzlxdm.equals("")) {
			sql.append(" and SAM_PLAN.PLAN_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(jzlxdm);
		}
		if (jzrqQs != null && !jzrqQs.equals("")) {
			sql.append(" and SAM_PLAN.PLAN_BEGIN >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(jzrqQs);
		}
		if (jzrqQt != null && !jzrqQt.equals("")) {
			sql.append(" and SAM_PLAN.PLAN_END <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(jzrqQt);
		}
		if (lrsjs != null && !lrsjs.equals("")) {
			sql.append(" and SAM_PLAN.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrsjs);
		}
		if (lrsjt != null && !lrsjt.equals("")) {
			sql.append(" and SAM_PLAN.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrsjt);
		}
		if (status != null && !status.equals("")) {
			sql.append(" and SAM_PLAN.STATUS= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(status);
		}
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,start, limit,true);
		}else{
			resultDs = this.executeDataset(sql.toString(),start, limit,true);
		}
		return resultDs;
	}

	/**
	 * 数据统计
	 * @param 
	 * @return
	 */
	public DataSet sjtj(){
		 String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		 StringBuffer sql = new StringBuffer();
			sql.append("select NVL(sum(FAMILY_NUM),0) as familySum,NVL(sum(PEOPLE_NUM),0) as peopleSum,NVL(sum(FUND),0) as moneySum from SAM_PLAN where status='0'") ;
		String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
				createOrgan=organCode.substring(0,2);
			}else if(organCode.substring(4,12).equals("00000000")){
				createOrgan=organCode.substring(0,4);
			}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
				createOrgan=organCode.substring(0,6);
			}else if(organCode.substring(9,12).equals("000")){
				createOrgan=organCode.substring(0,6);
			}else  {
				createOrgan=organCode.substring(0,6);
			}
		 sql.append("   and REG_ORGAN_REGION LIKE '").append(createOrgan).append("%'");
		DataSet ds=executeDataset(sql.toString(),true);
		return ds;
	}
	
	/**
	 * 已实施数据统计
	 * @param 
	 * @return
	 */
	public DataSet sjtjss(){
		 String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		 StringBuffer sql = new StringBuffer();
		sql.append("select NVL(sum(FAMILY_NUM),0) as familySum,NVL(sum(PEOPLE_NUM),0) as peopleSum,NVL(sum(FUND),0) as moneySum from SAM_PLAN where status='1'"); 
		String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
				createOrgan=organCode.substring(0,2);
			}else if(organCode.substring(4,12).equals("00000000")){
				createOrgan=organCode.substring(0,4);
			}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
				createOrgan=organCode.substring(0,6);
			}else if(organCode.substring(9,12).equals("000")){
				createOrgan=organCode.substring(0,6);
			}else  {
				createOrgan=organCode.substring(0,6);
			}
		 sql.append("   and REG_ORGAN_REGION LIKE '").append(createOrgan).append("%'");
		DataSet ds=executeDataset(sql.toString(),true);
		return ds;
	}
	
	/**
	 * 分析页面数据统计
	 * @param
	 * @return
	 */
	public DataSet sjtjAnalyze(){
		String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		 StringBuffer sql = new StringBuffer();
		sql.append("select NVL(sum(FAMILY_NUM),0) as familySum,NVL(sum(PEOPLE_NUM),0) as peopleSum,NVL(sum(FUND),0) as moneySum from SAM_PLAN");
		String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
				createOrgan=organCode.substring(0,2);
			}else if(organCode.substring(4,12).equals("00000000")){
				createOrgan=organCode.substring(0,4);
			}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
				createOrgan=organCode.substring(0,6);
			}else if(organCode.substring(9,12).equals("000")){
				createOrgan=organCode.substring(0,6);
			}else  {
				createOrgan=organCode.substring(0,6);
			}
		 sql.append("   WHERE REG_ORGAN_REGION LIKE '").append(createOrgan).append("%'");
		DataSet ds=executeDataset(sql.toString(),true);
		return ds;
	}
	
	/**
	 * 救助方案实施
	 * @param pset
	 * @return
	 */
	public void passJzfa(String[] jzfaids){
		String[] sql = new String[jzfaids.length];
		for (int i = 0; i < jzfaids.length; i++) {
			sql[i] = "update SAM_PLAN set status='1' where PLAN_ID='" + jzfaids[i] + "'";
		}
		batchUpdate(sql);
	}
	
	/**
	 * 更新主表中的救助金额等
	 * @param pset
	 * @return
	 */
	public void addJzje(Detail jzfamx,String jzfaid){
	
	 //更新主表中的救助资金金额、救助户数、救助人数等的计算方法 救助户数:家庭类型+单位类型 救助人数：个人类型+家庭类型中的家庭成员数+单位类型 Modified by fujw,2011-05-26.
		StringBuffer sql = new StringBuffer();
    sql.append("  UPDATE SAM_PLAN SET FUND=(SELECT SUM(TOTAL_FUND) FROM SAM_PLAN_DETAIL WHERE PLAN_ID = '").append(jzfaid).append("')");
    sql.append(" ,FAMILY_NUM= (SELECT count(*) FROM SAM_PLAN_DETAIL where (assisted_type='1' or assisted_type='2' ) and PLAN_ID ='").append(jzfaid).append("')");
    sql.append(" ,PEOPLE_NUM=(select sum(total) from ((SELECT count(*) total FROM SAM_PLAN_DETAIL a where (a.assisted_type='0' or a.assisted_type='2') and PLAN_ID = '").append(jzfaid).append("')");
    sql.append(" UNION (select sum(s.people_num) total from BASEINFO_FAMILY s,SAM_PLAN_DETAIL t where s.FAMILY_CARD_NO=t.ID_CARD and s.CHECK_FLAG='3' and t.assisted_type='1' and PLAN_ID = '").append(jzfaid).append("')) p )");
    sql.append(" WHERE  PLAN_ID='").append(jzfaid).append("'");
    logger.info("更新主表中的救助金额sql="+sql.toString());
		this.executeUpdate(sql.toString());
		
	}
	
	/**
	 * 更新主表中的救助金额等
	 * @param pset
	 * @return
	 */
	public void updateJzje(Detail jzfamx){
		String jzfaid=jzfamx.getPlanId();
		String sql="select NVL(sum(TOTAL_FUND),0) as totalfund from SAM_PLAN_DETAIL where PLAN_ID='"+jzfaid+"'";
		DataSet ds=executeDataset(sql,true);
		Record re=ds.getRecord(0);
		String str=re.get("TOTAL_FUND").toString();
		
		String sql1="update SAM_PLAN set FUND='"+str+"' where PLAN_ID='"+jzfaid+"' ";
		executeUpdate(sql1);
		
		
		
		
	}
	
	/**
	 * 更新主表中的救助金额等
	 * @param jzfamxid
	 * @return
	 */
	public void delJzje(String jzfamxid){
		String sql="select PLAN_ID,ASSISTED_TYPE,TOTAL_FUND from SAM_PLAN_DETAIL where DETAIL_ID='"+jzfamxid+"'";
		DataSet ds=executeDataset(sql,true);
		Record re=ds.getRecord(0);
		String jzfaid=re.get("PLAN_ID").toString();
		String szdxlxdm=re.get("ASSISTED_TYPE").toString();
		String jzzjhjje=re.get("TOTAL_FUND").toString();
		int jzhs=0;
		int jzrs=0;
		if(szdxlxdm.equals("0")){
			jzrs=jzrs+1;
		}
		if(szdxlxdm.equals("1")){
			jzhs=jzhs+1;
		}
		if(szdxlxdm.equals("2")){
			jzhs=jzhs+1;
			jzrs=jzrs+1;
		}
		String sql1="update SAM_PLAN set FUND=FUND-'"+jzzjhjje+"',FAMILY_NUM=FAMILY_NUM-'"+Integer.toString(jzhs)+"',PEOPLE_NUM=PEOPLE_NUM-'"+Integer.toString(jzrs)+"'  where PLAN_ID='"+jzfaid+"'";
		executeUpdate(sql1);
		
		
	}
	/**
	 * 改变数据库金额的值 如果为空则让数据库的合计金额为0
	 * @author lyq
	 * @return
	 * @data:2011-06-08
	 * */
	public void addJe(String jzfaid){
		
		String sql2="select FUND from SAM_PLAN where PLAN_ID='"+jzfaid+"' ";
		DataSet ds2=executeDataset(sql2,true);
		Record re2=ds2.getRecord(0);
		if(re2.get("FUND")==null||"".equals(re2.get("FUND"))){
			String sql3="update SAM_PLAN set  FUND=0  where  PLAN_ID='"+jzfaid+"' ";
			executeUpdate(sql3);
		}
		
	}
	/**
	 * 分析饼图页面的返回DataSet方法
	 * @param 
	 * @return
	 */
	public DataSet analyzeJzfa(String jzfaids){
		String jzfaids1= jzfaids.replace(",", "','");
		String sql="select PLAN_ORGAN_NAME as organName,count(PLAN_ORGAN_ID) as planCount,NVL(sum(FUND),0) as fund,NVL(sum(FAMILY_NUM),0) as familyNum,NVL(sum(PEOPLE_NUM),0) as peopleNum  from SAM_PLAN where PLAN_ID in ('"+jzfaids1+"') group by PLAN_ORGAN_NAME";
		DataSet ds=executeDataset(sql,true);
		return ds;

		}
	/**
	 * 分析饼图页面的返回DataSet方法
	 * @param 
	 * @return
	 */
	public DataSet analyzeJzfafx(String jzfaids){
		String jzfaids1= jzfaids.replace(",", "','");
		String sql = "select NVL(sum(FAMILY_NUM),0) as familySum,NVL(sum(PEOPLE_NUM),0) as peopleSum,NVL(sum(FUND),0) as moneySum from SAM_PLAN where PLAN_ID in ('"+jzfaids1+"')";
		DataSet ds=executeDataset(sql,true);
		return ds;
	}
/**
 * 查询救助方案救助人数、户数、资金
 * @param parameterSet
 * @return
 * licb 20110628
 */
	public DataSet getJzNum(ParameterSet params) {
		 StringBuffer jtfaSql = new StringBuffer();
			
			jtfaSql.append("select NVL(sum(s.FAMILY_NUM),0) as familySum,NVL(sum(s.PEOPLE_NUM),0) as peopleSum,NVL(sum(s.FUND),0) as moneySum from SAM_PLAN s ") ;
			//当前登陆人单位区划
			String  organCode=(String)params.getParameter("organArea"); 
			String  organType=(String)params.getParameter("organType");
			String  regOrganType=(String)params.getParameter("REG_ORGAN_TYPE");
			String jzfamc = (String) params.getParameter("PLAN_NAME");//救助方案名称
			String jzlxdm = (String) params.getParameter("PLAN_TYPE");//救助类型
			String jzrqQs = (String) params.getParameter("PLAN_BEGIN");//救助开始时间S
			String jzrqQt = (String) params.getParameter("PLAN_END");//救助开始时间T
			String lrsjs = (String) params.getParameter("REG_TIMES");//录入时间S
			String lrsjt = (String) params.getParameter("REG_TIMET");//录入时间T
			if(StringUtils.isNotEmpty(organType)){
				jtfaSql.append(",COM_PLAN_ORGAN e where STATUS='0' AND s.PLAN_ID=e.PLAN_ID  ");
				jtfaSql.append(" and e.ORGAN_TYPE='").append(organType).append("'  ");
			}else{
		//		jtfaSql.append(" and e.ORGAN_TYPE is null");
				jtfaSql.append("where STATUS='0' ");
			}
			//查询条件
			if (jzfamc != null && !jzfamc.equals("")) {
				jtfaSql.append(" and s.PLAN_NAME= '").append(jzfamc).append("'");
			}
			if (regOrganType != null && !regOrganType.equals("")) {
				jtfaSql.append(" and s.REG_ORGAN_TYPE= '").append(regOrganType).append("'");
			}
			if (jzlxdm != null && !jzlxdm.equals("")) {
				jtfaSql.append(" and s.PLAN_TYPE= '").append(jzlxdm).append("'");
			}
			if (jzrqQs != null && !jzrqQs.equals("")) {
				jtfaSql.append(" and s.PLAN_BEGIN >='").append(jzrqQs).append("'");
			}
			if (jzrqQt != null && !jzrqQt.equals("")) {
				jtfaSql.append(" and s.PLAN_END <='").append(jzrqQt).append("'");
			}
			if (lrsjs != null && !lrsjs.equals("")) {
				jtfaSql.append(" and s.REG_TIME>='").append(lrsjs).append("'");
			}
			if (lrsjt != null && !lrsjt.equals("")) {
				jtfaSql.append(" and s.REG_TIME<='").append(lrsjt).append("'");
			}
			 StringBuffer createOrgan=new StringBuffer();
			 if(organCode.substring(2,12).equals("0000000000")){
					createOrgan.append(organCode.substring(0,2));
				}else if(organCode.substring(4,12).equals("00000000")){
					createOrgan.append(organCode.substring(0,4));
				}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
					createOrgan.append(organCode.substring(0,6));
				}else if(organCode.substring(9,12).equals("000")){
					createOrgan.append(organCode.substring(0,6));
				}else  {
					createOrgan.append(organCode).substring(0,6);
				}
			 jtfaSql.append("   and s.PLAN_ORGAN_REGION LIKE '").append(createOrgan.toString()).append("%'");
			int start = params.getPageStart();
			int limit = params.getPageLimit();
			return executeDataset(jtfaSql.toString(), start, limit, true);
	}

	/**
	 * 查询已实施救助方案救助人数、户数、资金
	 * @param parameterSet
	 * @return
	 * licb 20110628
	 */
		public DataSet getJzfassNum(ParameterSet params,HttpServletRequest request) {
		StringBuffer jtfassSql = new StringBuffer();

		jtfassSql.append("select NVL(sum(s.FAMILY_NUM),0) as familySum,NVL(sum(s.PEOPLE_NUM),0) as peopleSum,NVL(sum(s.FUND),0) as moneySum from SAM_PLAN s "); 
		String organType="";
		StringBuffer buffCode=new StringBuffer();
		try{
			 organType=ExtBspInfo.getUserInfo(request).getOrganType();
		}catch (Exception e) {
			buffCode.append(BspUtil.getCorpOrgan().getOrganCode());
		}
		if(StringUtils.isNotEmpty(organType)){
			buffCode.append(ExtBspInfo.getUserInfo(request).getAreaCode());
		}
		String  regOrganType=(String)params.getParameter("REG_ORGAN_TYPE");
		String jzfamc = (String) params.getParameter("PLAN_NAME");//救助方案名称
		String jzlxdm = (String) params.getParameter("PLAN_TYPE");//救助类型
		String jzrqQs = (String) params.getParameter("PLAN_BEGIN");//救助开始时间S
		String jzrqQt = (String) params.getParameter("PLAN_END");//救助开始时间T
		String lrsjs = (String) params.getParameter("REG_TIMES");//录入时间S
		String lrsjt = (String) params.getParameter("REG_TIMET");//录入时间T
		String regId = (String) params.getParameter("REG_ORGAN_ID");//录入单位Id
		if(StringUtils.isNotEmpty(organType)){
			jtfassSql.append(",COM_PLAN_ORGAN e where  STATUS='1' AND s.PLAN_ID=e.PLAN_ID  ");
			jtfassSql.append(" and e.ORGAN_TYPE='").append(organType).append("'  ");
		}else{
		//	jtfassSql.append(" and e.ORGAN_TYPE is null");
			jtfassSql.append(" where  STATUS='1' ");
		}
		//查询条件
		if (jzfamc != null && !jzfamc.equals("")) {
			jtfassSql.append(" and s.PLAN_NAME= '").append(jzfamc).append(
					"'");
		}
		if (regOrganType != null && !regOrganType.equals("")) {
			jtfassSql.append(" and s.REG_ORGAN_TYPE= '").append(regOrganType).append("'");
		}
		if (jzlxdm != null && !jzlxdm.equals("")) {
			jtfassSql.append(" and s.PLAN_TYPE= '").append(jzlxdm).append(
					"'");
		}
		if (jzrqQs != null && !jzrqQs.equals("")) {
			jtfassSql.append(" and s.PLAN_BEGIN >='").append(jzrqQs).append(
					"'");
		}
		if (jzrqQt != null && !jzrqQt.equals("")) {
			jtfassSql.append(" and s.PLAN_END<='").append(jzrqQt).append(
					"'");
		}
		if (lrsjs != null && !lrsjs.equals("")) {
			jtfassSql.append(" and s.REG_TIME>='").append(lrsjs).append("'");
		}
		if (lrsjt != null && !lrsjt.equals("")) {
			jtfassSql.append(" and s.REG_TIME<='").append(lrsjt).append("'");
		}
		if (regId != null && !regId.equals("")) {
			jtfassSql.append(" and s.REG_ORGAN_ID ='").append(regId).append("'");
		}
		String createOrgan = "";
		String organCode=buffCode.toString();
		if (organCode.substring(2, 12).equals("0000000000")) {
			createOrgan = organCode.substring(0, 2);
		} else if (organCode.substring(4, 12).equals("00000000")) {
			createOrgan = organCode.substring(0, 4);
		} else if (organCode.substring(6, 12).equals("000000")
				|| organCode.substring(6, 12) == "000000") {
			createOrgan = organCode.substring(0, 6);
		} else if (organCode.substring(9, 12).equals("000")) {
			createOrgan = organCode.substring(0, 6);
		} else {
			createOrgan = organCode.substring(0,6);
		}
		jtfassSql.append(" AND s.PLAN_ORGAN_REGION LIKE '").append(createOrgan).append("%'");
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		return executeDataset(jtfassSql.toString(), start, limit, true);
	}
		/**
		 * 查询救助方案分析救助人数、户数、资金
		 * @param parameterSet
		 * @return
		 * licb 20110628
		 */
      public DataSet getJzfaAnalyze(ParameterSet params,HttpServletRequest request) {
		StringBuffer jtfassSql = new StringBuffer();

		jtfassSql.append("select NVL(sum(s.FAMILY_NUM),0) as familySum,NVL(sum(s.PEOPLE_NUM),0) as peopleSum,NVL(sum(s.FUND),0) as moneySum from SAM_PLAN s ");
		String organType="";
		StringBuffer buffCode=new StringBuffer();
		try{
		 organType=ExtBspInfo.getUserInfo(request).getOrganType();
		}catch (Exception e) {
			buffCode.append(BspUtil.getCorpOrgan().getOrganCode());
		}
		//当前登陆人单位区划
		
		if(StringUtils.isNotEmpty(organType)){
			buffCode.append(ExtBspInfo.getUserInfo(request).getAreaCode());
		}
		String  regOrganType=(String)params.getParameter("REG_ORGAN_TYPE");
		String ssztbz = (String) params.getParameter("STATUS");//实施状态
		String jzfamc = (String) params.getParameter("PLAN_NAME");//救助方案名称
		String jzdwmc = (String) params.getParameter("PLAN_ORGAN_NAME");//救助单位
		String jzrqQs = (String) params.getParameter("PLAN_BEGIN");//救助开始时间S
		String jzrqQt = (String) params.getParameter("PLAN_END");//救助开始时间T
		String lrsjs = (String) params.getParameter("REG_TIMES");//录入时间S
		String lrsjt = (String) params.getParameter("REG_TIMET");//录入时间T
		if(StringUtils.isNotEmpty(organType)){
			jtfassSql.append(",COM_PLAN_ORGAN e where s.PLAN_ID=e.PLAN_ID ");
			jtfassSql.append(" and e.ORGAN_TYPE='").append(organType).append("'  ");
		}else{
//			jtfassSql.append(" and e.ORGAN_TYPE is null");
			jtfassSql.append(" where 1=1 ");
		}
		//查询条件
		if (ssztbz != null && !ssztbz.equals("")) {
			jtfassSql.append(" and s.STATUS= '").append(ssztbz).append(
					"'");
		}
		if (regOrganType != null && !regOrganType.equals("")) {
			jtfassSql.append(" and s.REG_ORGAN_TYPE= '").append(regOrganType).append(
					"'");
		}
		if (jzfamc != null && !jzfamc.equals("")) {
			jtfassSql.append(" and s.PLAN_NAME= '").append(jzfamc).append(
					"'");
		}
		if (jzdwmc != null && !jzdwmc.equals("")) {
			jtfassSql.append(" and s.PLAN_ORGAN_NAME= '").append(jzdwmc).append(
					"'");
		}
		if (jzrqQs != null && !jzrqQs.equals("")) {
			jtfassSql.append(" and s.PLAN_BEGIN >='").append(jzrqQs)
					.append("'");
		}
		if (jzrqQt != null && !jzrqQt.equals("")) {
			jtfassSql.append(" and s.PLAN_END<='").append(jzrqQt).append(
					"'");
		}
		if (lrsjs != null && !lrsjs.equals("")) {
			jtfassSql.append(" and s.REG_TIME>='").append(lrsjs)
					.append("'");
		}
		if (lrsjt != null && !lrsjt.equals("")) {
			jtfassSql.append(" and s.REG_TIME<='").append(lrsjt)
					.append("'");
		}
		String createOrgan = "";
		String organCode=buffCode.toString();
		if (organCode.substring(2, 12).equals("0000000000")) {
			createOrgan = organCode.substring(0, 2);
		} else if (organCode.substring(4, 12).equals("00000000")) {
			createOrgan = organCode.substring(0, 4);
		} else if (organCode.substring(6, 12).equals("000000")
				|| organCode.substring(6, 12) == "000000") {
			createOrgan = organCode.substring(0, 6);
		} else if (organCode.substring(9, 12).equals("000")) {
			createOrgan = organCode.substring(0, 6);
		} else {
			createOrgan = organCode.substring(0,6);
		}
		jtfassSql.append(" AND s.PLAN_ORGAN_REGION LIKE '").append(createOrgan).append("%'");
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		return executeDataset(jtfassSql.toString(), start, limit, true);
	}
    /**
	 * 1-家庭救助历史信息
	 * @param pset
	 * @return
	 */
	public DataSet getFamilyAssist(ParameterSet params) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String assistedName = (String) params.getParameter("assistedName");//救助对象名称
		String assistedIdCard = (String) params.getParameter("assistedIdCard");//救助对象身份证
		String assistedOrganName = (String) params.getParameter("assistedOrganName");//救助单位名称
		String planBegin = (String) params.getParameter("planBegin");//受助日期S
		String planEnd = (String) params.getParameter("planEnd");//受助日期T
		String lrrqQ = (String) params.getParameter("lrrqQ");//录入时间S
		String lrrqZ = (String) params.getParameter("lrrqZ");//录入时间T
		String planType = (String) params.getParameter("planType");//救助类型
		
		StringBuffer jtfassSql = new StringBuffer();

		jtfassSql.append("SELECT A.PLAN_NAME AS PLAN_NAME, A.PLAN_TYPE AS PLAN_TYPE, B.ASSISTED_NAME AS ASSISTED_NAME,B.ID_CARD AS ID_CARD ,B.ASSITANCE_DATE AS ASSITANCE_DATE,"); 
		jtfassSql.append(" B.TOTAL_FUND AS TOTAL_FUND,A.PLAN_ORGAN_NAME "); 
		jtfassSql.append(" FROM SAM_PLAN_DETAIL B,SAM_PLAN A WHERE B.ASSISTED_TYPE='1' "); 
		jtfassSql.append(" AND B.ASSISTED_ID  IN ( SELECT t.FAMILY_ID FROM BASEINFO_PEOPLE t WHERE "); 
		jtfassSql.append(" t.Name = ? "); 
		typeList.add(Types.VARCHAR);
		argsList.add(assistedName);
		jtfassSql.append(" AND t.ID_CARD = ? "); 
		typeList.add(Types.VARCHAR);
		argsList.add(assistedIdCard);
		jtfassSql.append(")");
		 
		//查询条件
		if (assistedOrganName != null && !assistedOrganName.equals("")) {//救助单位名称
			jtfassSql.append(" and a.PLAN_ORGAN_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(assistedOrganName);
		}
		if (planBegin != null && !planBegin.equals("")) {//受助日期S
			jtfassSql.append(" and a.PLAN_BEGIN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planBegin);
		}
		if (planEnd != null && !planEnd.equals("")) {//受助日期T
			jtfassSql.append(" and a.PLAN_END >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planEnd);
		}
		if (lrrqQ != null && !lrrqQ.equals("")) {//录入时间S
			jtfassSql.append(" and a.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqQ);
		}
		if (lrrqZ != null && !lrrqZ.equals("")) {//录入时间T
			jtfassSql.append(" and a.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqZ);
		}
		if (planType != null && !planType.equals("")) {//救助类型
			jtfassSql.append(" and a.PLAN_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planType);
		}
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtfassSql.toString(),types,args,start, limit,true);
		}else{
			resultDs = this.executeDataset(jtfassSql.toString(),start, limit,true);
		}
		return resultDs;
	}

	/**
	 * 2-本人救助历史信息
	 * @param pset
	 * @return
	 */
	public DataSet getPersonAssist(ParameterSet params) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String assistedName = (String) params.getParameter("assistedName");//救助对象名称
		String assistedIdCard = (String) params.getParameter("assistedIdCard");//救助对象身份证
		String assistedOrganName = (String) params.getParameter("assistedOrganName");//救助单位名称
		String planBegin = (String) params.getParameter("planBegin");//受助日期S
		String planEnd = (String) params.getParameter("planEnd");//受助日期T
		String lrrqQ = (String) params.getParameter("lrrqQ");//录入时间S
		String lrrqZ = (String) params.getParameter("lrrqZ");//录入时间T
		String planType = (String) params.getParameter("planType");//救助类型
		StringBuffer jtfassSql = new StringBuffer();
		jtfassSql.append("SELECT A.PLAN_NAME AS PLAN_NAME ,A.PLAN_TYPE AS PLAN_TYPE, B.ASSISTED_NAME AS ASSISTED_NAME,B.ID_CARD AS ID_CARD ,B.ASSITANCE_DATE AS ASSITANCE_DATE,"); 
		jtfassSql.append(" B.TOTAL_FUND AS TOTAL_FUND,A.PLAN_ORGAN_NAME "); 
		jtfassSql.append(" FROM SAM_PLAN_DETAIL B,SAM_PLAN A WHERE ( B.ASSISTED_TYPE='0' OR B.ASSISTED_TYPE='2') "); 
		jtfassSql.append(" AND A.PLAN_ID = B.PLAN_ID　 "); 
		jtfassSql.append(" AND B.ASSISTED_NAME= ? "); 
		typeList.add(Types.VARCHAR);
		argsList.add(assistedName);
		jtfassSql.append(" AND B.ID_CARD = ? "); 
		typeList.add(Types.VARCHAR);
		argsList.add(assistedIdCard);
		 
		//查询条件
		if (assistedOrganName != null && !assistedOrganName.equals("")) {//救助单位名称
			jtfassSql.append(" and a.PLAN_ORGAN_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(assistedOrganName);
		}
		if (planBegin != null && !planBegin.equals("")) {//受助日期S
			jtfassSql.append(" and a.PLAN_BEGIN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planBegin);
		}
		if (planEnd != null && !planEnd.equals("")) {//受助日期T
			jtfassSql.append(" and a.PLAN_END >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planEnd);
		}
		if (lrrqQ != null && !lrrqQ.equals("")) {//录入时间S
			jtfassSql.append(" and a.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqQ);
		}
		if (lrrqZ != null && !lrrqZ.equals("")) {//录入时间T
			jtfassSql.append(" and a.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqZ);
		}
		if (planType != null && !planType.equals("")) {//救助类型
			jtfassSql.append(" and a.PLAN_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planType);
		}
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtfassSql.toString(),types,args,start, limit,true);
		}else{
			resultDs = this.executeDataset(jtfassSql.toString(),start, limit,true);
		}
		return resultDs;
	}

	/**
	 * 3-家庭其他成员历史信息
	 * @param pset
	 * @return
	 */
	public DataSet getOtherPersonAssist(ParameterSet params) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String assistedName = (String) params.getParameter("assistedName");//救助对象名称
		String assistedIdCard = (String) params.getParameter("assistedIdCard");//救助对象身份证
		String assistedOrganName = (String) params.getParameter("assistedOrganName");//救助单位名称
		String planBegin = (String) params.getParameter("planBegin");//受助日期S
		String planEnd = (String) params.getParameter("planEnd");//受助日期T
		String lrrqQ = (String) params.getParameter("lrrqQ");//录入时间S
		String lrrqZ = (String) params.getParameter("lrrqZ");//录入时间T
		String planType = (String) params.getParameter("planType");//救助类型
		StringBuffer jtfassSql = new StringBuffer();
		String szdxId = getJtidBysfzh(assistedName,assistedIdCard);//受助对象ID
		if(szdxId==null){
			szdxId="";
		}
		jtfassSql.append("SELECT A.PLAN_ID AS PLAN_ID, A.PLAN_NAME AS PLAN_NAME ,A.PLAN_TYPE AS PLAN_TYPE, B.ASSISTED_NAME AS ASSISTED_NAME,B.ID_CARD AS ID_CARD ,B.ASSITANCE_DATE AS ASSITANCE_DATE,"); 
		jtfassSql.append(" B.TOTAL_FUND AS TOTAL_FUND,A.PLAN_ORGAN_NAME "); 
		jtfassSql.append(" FROM SAM_PLAN_DETAIL B,SAM_PLAN A WHERE B.ASSISTED_TYPE='0' "); 
		if(!szdxId.equals("")) {
	    jtfassSql.append(" AND A.PLAN_ID=B.PLAN_ID ");	 
	    jtfassSql.append(" AND B.ASSISTED_ID= ? "); 
	    typeList.add(Types.VARCHAR);
		argsList.add(szdxId);
		}else if(szdxId.equals(""))  {
	    jtfassSql.append(" AND 1=2 "); 
		}
		//查询条件
		if (assistedOrganName != null && !assistedOrganName.equals("")) {//救助单位名称
			jtfassSql.append(" and a.PLAN_ORGAN_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(assistedOrganName);
		}
		if (planBegin != null && !planBegin.equals("")) {//受助日期S
			jtfassSql.append(" and a.PLAN_BEGIN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planBegin);
		}
		if (planEnd != null && !planEnd.equals("")) {//受助日期T
			jtfassSql.append(" and a.PLAN_END >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planEnd);
		}
		if (lrrqQ != null && !lrrqQ.equals("")) {//录入时间S
			jtfassSql.append(" and a.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqQ);
		}
		if (lrrqZ != null && !lrrqZ.equals("")) {//录入时间T
			jtfassSql.append(" and a.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrrqZ);
		}
		if (planType != null && !planType.equals("")) {//救助类型
			jtfassSql.append(" and a.PLAN_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planType);
		}
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtfassSql.toString(),types,args,start, limit,true);
		}else{
			resultDs = this.executeDataset(jtfassSql.toString(),start, limit,true);
		}
		return resultDs;
	}
	
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	public String getJtidBysfzh(String assistedName,String sfzh) {
		//初期数据未能审核，打开校验 licb  20110616
		//String sql = "select s.jtid from ygjz_jtxx s,ygjz_jtxx_cyxx t where s.jtid=t.jtid and s.shbz='3' and t.sfzh=?";
	    String sql = "select s.FAMILY_ID from BASEINFO_PEOPLE t,BASEINFO_FAMILY s where s.FAMILY_ID=t.FAMILY_ID   and  t.NAME=?  and t.ID_CARD=? ";
		
		DataSet ds = this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{assistedName,sfzh}, true);
		if(ds != null) {
			if(ds.getCount() != 0) {
				Record rec = ds.getRecord(0);
				String jtid = rec.get("FAMILY_ID").toString();
				return jtid;
			}
		}
		return "";
	}
}
