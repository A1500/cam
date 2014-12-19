package com.inspur.sdmz.jzfa.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.jzfa.dao.IDetailDao;
import com.inspur.sdmz.jzfa.data.Detail;

/**
 * 救助方案明细Dao
 * @author shgtch
 * @date 2011-4-16
 */
public class DetailDao extends EntityDao<Detail> implements IDetailDao {

	public final static String JZFAMX_DELETE_BYJZFAID = "DELETE FROM SAM_PLAN_DETAIL WHERE plan_id = ?";
	
	public final static String JZFAMX_QUERY_BYJZFAID = "SELECT * FROM SAM_PLAN_DETAIL WHERE plan_id = ?";
	
	@Override
	protected Class getEntityClass() {
		return Detail.class;
	}
	
	/**
	 * 增加一条救助方案明细
	 * @param jzfamx
	 */
	public void addJzfamx(Detail jzfamx) {
		this.insert(jzfamx);
	}
	
	/**
	 * 修改一条救助方案明细
	 * @param jzfamx
	 */
	public void updateJzfamx(Detail jzfamx) {
		this.update(jzfamx);
	}
	
	/**
	 * 删除一条救助方案明细
	 * @param jzfamxid
	 */
	public void deleteJzfamx(String jzfamxid) {
		this.delete(jzfamxid);
	}

	/**
	 * 通过救助方案ID删除救助方案明细
	 * @param jzfaid
	 */
	public void deleteJzfamxByJzfaid(String jzfaid) {
		this.executeUpdate(JZFAMX_DELETE_BYJZFAID, new int[] { Types.VARCHAR }, new Object[] { jzfaid });
	}
	
	/**
	 * 查询救助方案明细
	 * @param pset
	 * @return
	 */
	public DataSet jzfamxQuery(ParameterSet pset) {
		return this.query(pset);
	}
	
	/**
	 * 根据救助方案内码查询救助方案明细
	 * @param jzfaid
	 * @return
	 */
	public DataSet jzfamxQueryByJzfaid(String jzfaid) {
		return null;
	}

	/**
	 * 明细数据统计
	 * @return
	 */
	public DataSet sjtjmx(ParameterSet params,String jzfaid){

		//String sql = "select count(DETAIL_ID) as peopleSum,NVL(sum(CAPTIAL),0) as moneySum,NVL(sum(GOODS_NUMs),0) as goodsSum,NVL(sum(TOTAL_FUND),0) as totalSum from SAM_PLAN_DETAIL where PLAN_ID='"+jzfaid+"'";
		//DataSet ds=executeDataset(sql,true);
		//return ds;
		
		StringBuffer jtfassSql = new StringBuffer();

		jtfassSql.append("select count(DETAIL_ID) as peopleSum,NVL(sum(CAPTIAL),0) as moneySum,NVL(sum(GOODS_NUMs),0) as goodsSum,NVL(sum(TOTAL_FUND),0) as totalSum from SAM_PLAN_DETAIL where PLAN_ID='"+jzfaid+"'"); 
		
		String jzfamc = (String) params.getParameter("ASSISTED_NAME");//受助对象名称
		String jzlxdm = (String) params.getParameter("ASSISTED_TYPE");//受助对象类型
		String jzrqQs = (String) params.getParameter("PLAN_BEGIN");//救助开始时间S
		String jzrqQt = (String) params.getParameter("PLAN_END");//救助开始时间T
		String lrsjs = (String) params.getParameter("REG_TIMES");//录入时间S
		String lrsjt = (String) params.getParameter("REG_TIMET");//录入时间T
		String idCard = (String) params.getParameter("ID_CARD");//身份证号
		String disabilityType = (String) params.getParameter("DISABILITY_TYPE");//残疾类型
		String disabilityLevel = (String) params.getParameter("DISABILITY_LEVEL");//残疾等级
		String handicapNum = (String) params.getParameter("HANDICAP_NUM");//残疾证号

		//查询条件
		if (jzfamc != null && !jzfamc.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.ASSISTED_NAME= '").append(jzfamc).append(
					"'");
		}
		if (jzlxdm != null && !jzlxdm.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.ASSISTED_TYPE= '").append(jzlxdm).append(
					"'");
		}
		if (jzrqQs != null && !jzrqQs.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.ASSITANCE_DATE >='").append(jzrqQs).append(
					"'");
		}
		if (jzrqQt != null && !jzrqQt.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.ASSITANCE_DATE<='").append(jzrqQt).append(
					"'");
		}
		if (lrsjs != null && !lrsjs.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.REG_TIME>='").append(lrsjs).append("'");
		}
		if (lrsjt != null && !lrsjt.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.REG_TIME<='").append(lrsjt).append("'");
		}
		if (idCard != null && !idCard.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.ID_CARD ='").append(idCard).append("'");
		}
		if (disabilityType != null && !disabilityType.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.DISABILITY_TYPE ='").append(disabilityType).append("'");
		}
		if (disabilityLevel != null && !disabilityLevel.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.DISABILITY_LEVEL ='").append(disabilityLevel).append("'");
		}
		if (handicapNum != null && !handicapNum.equals("")) {
			jtfassSql.append(" and SAM_PLAN_DETAIL.HANDICAP_NUM ='").append(handicapNum).append("'");
		}
		
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		return executeDataset(jtfassSql.toString(), start, limit, true);
	}
	
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	public String getCheckedJtidBysfzh(String sfzh) {
		//初期数据未能审核，打开校验 licb  20110616
		//String sql = "select s.jtid from ygjz_jtxx s,ygjz_jtxx_cyxx t where s.jtid=t.jtid and s.shbz='3' and t.sfzh=?";
	    String sql = "select s.FAMILY_ID from BASEINFO_PEOPLE t,BASEINFO_FAMILY s where s.FAMILY_ID=t.FAMILY_ID   and t.ID_CARD=?";
		
		DataSet ds = this.executeDataset(sql, new int[]{Types.VARCHAR}, new Object[]{sfzh}, true);
		if(ds != null) {
			if(ds.getCount() != 0) {
				Record rec = ds.getRecord(0);
				String jtid = rec.get("FAMILY_ID").toString();
				return jtid;
			}
		}
		return "";
	}
	/**
	 * 救助方案重复救助查询
	 * @param sfzh
	 * @return
	 */
public DataSet jzfaCfjz(ParameterSet pset,String planId){
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT  CFCX.family_id , CFCX.PLAN_ID , CFCX.FAMILY_NAME ,     ");
		sql.append("      CFCX.jtcy , CFCX.num , CFCX.jzqk ,JZFA.PLAN_NAME AS JZFAMC");
		sql.append("      FROM");
		
		sql.append("    (SELECT baseinfo_family.family_id as family_id,vv.PLAN_ID as PLAN_ID,baseinfo_family.FAMILY_NAME as FAMILY_NAME,");
		sql.append("   totalname(baseinfo_family.FAMILY_ID) as JTCY,vv.num as NUM,getrepeatorgan(vv.ASSISTED_ID) as JZQK ");
		sql.append("   FROM baseinfo_family,");
		sql.append("   (SELECT COUNT(*) NUM,PLAN_ID,ASSISTED_ID FROM sam_plan_detail");
		sql.append("   WHERE ASSISTED_ID IS NOT NULL");
		sql.append("  GROUP BY PLAN_ID,ASSISTED_ID");
		sql.append("   HAVING COUNT(*) >1");
		sql.append("   ) vv");
		sql.append("   WHERE baseinfo_family.family_id = vv.ASSISTED_ID");
		
		//String planId = (String) pset.getParameter("planId");
		
		sql.append("    AND PLAN_ID in ('").append(planId.replaceAll(",", "','")).append("')) ");
		sql.append("     CFCX,sam_plan  JZFA WHERE CFCX.PLAN_ID=JZFA.PLAN_ID ");
		return this.executeDataset(sql.toString(),true);
		
		}
		
	/**
	 * 查询受助人在其他救助方案中的信息
	 */
	public DataSet queryOtherAssisted(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String idCard = (String) pset.getParameter("idCard");
		String detailId = (String) pset.getParameter("detailId");
		sql.append("select pd.ASSISTED_NAME,pd.ASSISTED_TYPE,pd.ASSITANCE_DATE,pd.CAPTIAL,pd.GOODS_NAME,pd.GOODS_NUM,pd.GOODS_NUMS,pd.TOTAL_FUND,pd.ASSISTED_SIDE,p.PLAN_ORGAN_NAME,p.PLAN_BEGIN,p.FUND from SAM_PLAN_DETAIL pd,SAM_PLAN p where pd.ID_CARD='"+idCard+"' and pd.DETAIL_ID!='"+detailId+"' and pd.PLAN_ID = p.PLAN_ID");
		return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
	}
}
