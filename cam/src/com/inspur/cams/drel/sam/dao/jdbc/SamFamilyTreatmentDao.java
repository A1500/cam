package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;

/**
 * @title:家庭待遇信息Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public class SamFamilyTreatmentDao extends EntityDao<SamFamilyTreatment> implements ISamFamilyTreatmentDao{

 	public SamFamilyTreatmentDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamFamilyTreatment.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamFamilyTreatment");
	}
   
	public DataSet queryAdjustList(ParameterSet pset){
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		List<Object> argsList = new ArrayList<Object>();
		argsList.add(pset.getParameter("queryDate"));
		argsList.add(pset.getParameter("queryDate"));
		argsList.add(pset.getParameter("assistanceType"));
		argsList.add(pset.getParameter("domicileCode"));
		querySql.append("select a.treatment_id,                           \n");
		querySql.append("       b.family_id,                              \n");
		querySql.append("       b.domicile_name,                          \n");
		querySql.append("       b.family_card_no,                         \n");
		querySql.append("       b.family_name,                            \n");
		querySql.append("       b.assistance_people_num,                  \n");
		querySql.append("       b.belonging,                              \n");
		querySql.append("       b.year_average_income,                    \n");
		querySql.append("       b.month_average_income,                   \n");
		querySql.append("       a.assistance_money,                       \n");
		querySql.append("       b.assistance_class,                       \n");
		querySql.append("       a.assistance_class_money,                 \n");
		querySql.append("       a.adjust_date			                  \n");
		querySql.append("  from sam_family_treatment a, baseinfo_family_archive b \n");
		querySql.append(" where a.family_id = b.family_id                 \n");
		querySql.append(" 	and a.apply_id = b.apply_id                   \n");
		querySql.append("   and a.begin_date <= ?                         \n");
		querySql.append("   and a.end_date >= ?                           \n");
		querySql.append("   and a.assistance_type = ?                     \n");
		querySql.append("   and b.domicile_code like ?                    \n");
		String familyName=StrUtil.n2b((String)pset.getParameter("familyName"));
		if(!"".equals(familyName)){
			querySql.append("   and b.family_name like ?                    \n");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+familyName+"%");
		}
		String familyCardNo=StrUtil.n2b((String)pset.getParameter("familyCardNo"));
		if(!"".equals(familyCardNo)){
			querySql.append("   and b.family_card_no = ?                    \n");
			typeList.add(Types.VARCHAR);
			argsList.add(familyCardNo);
		}
		String assistanceMoneyStart=StrUtil.n2b((String)pset.getParameter("assistanceMoneyStart"));
		if(!"".equals(assistanceMoneyStart)){
			querySql.append("   and a.assistance_money >= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyStart);
		}
		String assistanceMoneyEnd=StrUtil.n2b((String)pset.getParameter("assistanceMoneyEnd"));
		if(!"".equals(assistanceMoneyEnd)){
			querySql.append("   and a.assistance_money <= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyEnd);
		}
		String assistancePeopleNumStart=StrUtil.n2b((String)pset.getParameter("assistancePeopleNumStart"));
		if(!"".equals(assistancePeopleNumStart)){
			querySql.append("   and b.assistance_people_num >= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistancePeopleNumStart);
		}
		String assistancePeopleNumEnd=StrUtil.n2b((String)pset.getParameter("assistancePeopleNumEnd"));
		if(!"".equals(assistancePeopleNumEnd)){
			querySql.append("   and b.assistance_people_num <= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistancePeopleNumEnd);
		}
		String releaseId=StrUtil.n2b((String)pset.getParameter("releaseId"));
		if(!"".equals(releaseId)){
			querySql.append("   and not exists              \n");
			querySql.append("       (                       \n");
			querySql.append("          select family_id from sam_release_detail d where a.family_id=d.family_id and release_id=?  \n");
		    querySql.append("       )   \n");
		    typeList.add(Types.VARCHAR);
			argsList.add(releaseId);
		}
		querySql.append(" ORDER BY A.DOMICILE_CODE ,B.FAMILY_ID");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		if (pset.getPageStart() < 0 || pset.getPageLimit() < 0) {
			return executeDataset(querySql.toString(),types, args, true);
		} else {
			return executeDataset(querySql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		}
	}
   /**
    * 身份证校验的时候查询待遇表，看是否正在进行救助
    * @param pset FAMILY_ID
    * @return
    */
	public DataSet queryForCheckIDCard(ParameterSet pset) {
		 StringBuffer querySql = new StringBuffer();
		 querySql.append("select * from SAM_FAMILY_TREATMENT t where t.family_id=? and t.ASSISTANCE_TYPE in ('01','02','03') and   t.END_DATE >= ? ");
		  List<Object> typeList = new ArrayList<Object>();
		  typeList.add(Types.VARCHAR);
		  typeList.add(Types.VARCHAR);
		  List<Object> argsList = new ArrayList<Object>();
		  argsList.add(pset.getParameter("FAMILY_ID"));
		  argsList.add(DateUtil.getMonth());
		  int[] types = new int[typeList.size()];
		  for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		  }
		  Object[] args = argsList.toArray(new Object[argsList.size()]);
		  return executeDataset(querySql.toString(),types,args,true);
	}
	/**
	 * 调整所有保障金
	 * @param treatmentIdId
	 * @param assistanceMoneyAddValue
	 * @param adjustMoney
	 */
	public void updateAllAssistanceMoney(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		List<Object> argsList = new ArrayList<Object>();
		String adjustType=(String) pset.getParameter("adjustType");//调整类型
		String adjustTarget=(String) pset.getParameter("adjustTarget");//调整目标
		argsList.add(pset.getParameter("adjustMoney"));
		argsList.add(pset.getParameter("queryDate"));
		argsList.add(pset.getParameter("queryDate"));
		argsList.add(pset.getParameter("assistanceType"));
		argsList.add(pset.getParameter("domicileCode"));
		sql.append("UPDATE SAM_FAMILY_TREATMENT T                    									\n");
		if ("01".equals(adjustType)) {//户月保障金
			if ("01".equals(adjustTarget)) {//家庭
				sql.append("SET T.ASSISTANCE_MONEY = nvl(T.ASSISTANCE_MONEY,0) + ?,									\n");				
			}else if ("02".equals(adjustTarget)) {//保障人口
				sql.append("SET T.ASSISTANCE_MONEY = nvl(T.ASSISTANCE_MONEY,0) + nvl(T.ASSISTANCE_PEOPLE_NUM,0) * ?,		\n");				
			}
		}else if ("02".equals(adjustType)) {//分类施保金
			if ("01".equals(adjustTarget)) {//家庭
				sql.append("SET T.ASSISTANCE_CLASS_MONEY = nvl(T.ASSISTANCE_CLASS_MONEY,0) + ?,									\n");				
			}else if ("02".equals(adjustTarget)) {//保障人口
				sql.append("SET T.ASSISTANCE_CLASS_MONEY = nvl(T.ASSISTANCE_CLASS_MONEY,0) + nvl(T.ASSISTANCE_PEOPLE_NUM,0) * ?,		\n");				
			}
		}
		sql.append("	T.ADJUST_DATE = TO_CHAR(SYSDATE,'YYYY-MM-DD')									\n");		
		sql.append("WHERE EXISTS (                      												\n");
		sql.append("select a.treatment_id,                           \n");
		sql.append("       b.family_id,                              \n");
		sql.append("       b.domicile_name,                          \n");
		sql.append("       b.family_card_no,                         \n");
		sql.append("       b.family_name,                            \n");
		sql.append("       b.assistance_people_num,                  \n");
		sql.append("       b.belonging,                              \n");
		sql.append("       b.year_average_income,                    \n");
		sql.append("       b.month_average_income,                   \n");
		sql.append("       a.assistance_money,                       \n");
		sql.append("       b.assistance_class,                       \n");
		sql.append("       a.assistance_class_money,                 \n");
		sql.append("       a.adjust_date			                 \n");
		sql.append("  from sam_family_treatment a, baseinfo_family_archive b \n");
		sql.append(" where a.family_id = b.family_id                 \n");
		sql.append("   and a.apply_id = b.apply_id                   \n");
		sql.append("   AND T.TREATMENT_ID = A.TREATMENT_ID           \n");
		sql.append("   and a.begin_date <= ?                         \n");
		sql.append("   and a.end_date >= ?                           \n");
		sql.append("   and a.assistance_type = ?                     \n");
		sql.append("   and b.domicile_code like ?                    \n");
		String familyName=StrUtil.n2b((String)pset.getParameter("familyName"));
		if(!"".equals(familyName)){
			sql.append("   and b.family_name like ?                    \n");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+familyName+"%");
		}
		String familyCardNo=StrUtil.n2b((String)pset.getParameter("familyCardNo"));
		if(!"".equals(familyCardNo)){
			sql.append("   and b.family_card_no = ?                    \n");
			typeList.add(Types.VARCHAR);
			argsList.add(familyCardNo);
		}
		String assistanceMoneyStart=StrUtil.n2b((String)pset.getParameter("assistanceMoneyStart"));
		if(!"".equals(assistanceMoneyStart)){
			sql.append("   and a.assistance_money >= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyStart);
		}
		String assistanceMoneyEnd=StrUtil.n2b((String)pset.getParameter("assistanceMoneyEnd"));
		if(!"".equals(assistanceMoneyEnd)){
			sql.append("   and a.assistance_money <= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyEnd);
		}
		String assistancePeopleNumStart=StrUtil.n2b((String)pset.getParameter("assistancePeopleNumStart"));
		if(!"".equals(assistancePeopleNumStart)){
			sql.append("   and b.assistance_people_num >= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistancePeopleNumStart);
		}
		String assistancePeopleNumEnd=StrUtil.n2b((String)pset.getParameter("assistancePeopleNumEnd"));
		if(!"".equals(assistancePeopleNumEnd)){
			sql.append("   and b.assistance_people_num <= ?                    \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistancePeopleNumEnd);
		}
		String releaseId=StrUtil.n2b((String)pset.getParameter("releaseId"));
		if(!"".equals(releaseId)){
			sql.append("   and not exists              \n");
			sql.append("       (                       \n");
			sql.append("          select family_id from sam_release_detail d where a.family_id=d.family_id and release_id=?  \n");
		    sql.append("       )   \n");
		    typeList.add(Types.VARCHAR);
			argsList.add(releaseId);
		}
		sql.append(")                      															\n");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		executeUpdate(sql.toString(), types, args);
	}

	public void deleteTreatment(String familyId) {
		if( familyId != null && !"".equals(familyId)){
			executeUpdate("DELETE FROM sam_family_treatment WHERE FAMILY_ID = ?", new int[] { Types.VARCHAR },
					new Object[] { familyId });
		}
	}	
}
