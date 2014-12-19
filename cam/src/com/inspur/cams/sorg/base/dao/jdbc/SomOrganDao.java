package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.dao.ISomOrganDao;
import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 社会组织dao实现类
 * @author Muqi
 * @date 2011-5-11
 */
public class SomOrganDao extends EntityDao<SomOrgan> implements ISomOrganDao {

	@Override
	protected Class<SomOrgan> getEntityClass() {
		return SomOrgan.class;
	}
	/**
	 * 更新是否登记党建信息
	 */
	public void updateRegPartyById(String sorgId,String status) {
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR};
		Object[] args = new Object[] {status,sorgId};
		StringBuffer buff=new StringBuffer();
		buff.append("UPDATE SOM_ORGAN SET IF_REG_PARTY = ?");
		buff.append("WHERE  SORG_ID = ?");
		executeUpdate(buff.toString(), types, args);
	}
	/**
	 * 更新换届选举日期
	 */
	public void updateElectionDate(String sorgId,String electionDate,Integer electionPriod) {
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		Object[] args = new Object[] {electionDate,electionPriod,sorgId};
		StringBuffer buff=new StringBuffer();
		buff.append("UPDATE SOM_ORGAN SET ELECTION_DATE = ?");
		buff.append(" , ELECTION_PERIOD = ?");
		buff.append(" WHERE  SORG_ID = ?");
		executeUpdate(buff.toString(), types, args);
	}
	
	/**
	 * 分支基本信息的综合查询
	 * 
	 * @param pset
	 * @return DataSet
	 */
	@SuppressWarnings("unchecked")
	public DataSet totalQueryBranch(ParameterSet pset){
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		sql.append("SELECT O.SORG_ID SORG_ID,O.SORG_CODE SORG_CODE,O.CN_NAME CN_NAME,O.SORG_STATUS SORG_STATUS,M.CN_NAME M_CN_NAME,M.MORG_NAME M_MORG_NAME FROM SOM_ORGAN O, SOM_ORGAN M WHERE O.MAIN_SORG_ID = M.SORG_ID AND O.IF_BRANCH = 1 ");
		String sorgType = (String) pset.getParameter("sorgType");	
		sql.append(" AND O.SORG_TYPE='").append(sorgType).append("' ");
		String m_cnName = (String) pset.getParameter("m_cnName");	// 社团主体名称
		String m_sorgCode = (String) pset.getParameter("m_sorgCode");	// 社团主体登记证号
		String sorgStatus = (String) pset.getParameter("sorgStatus");		// 分支/代表机构状态
		String cnName = (String) pset.getParameter("cnName");				// 分支/代表机构名称
		String sorgCode = (String) pset.getParameter("sorgCode");			// 分支/代表机构登记证号
		String morgName = (String) pset.getParameter("morgName");			// 登记管理机关
		if (m_cnName != null && !"".equals(m_cnName)) {
			sql.append(" AND M.CN_NAME like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(m_cnName);
		}
		if (m_sorgCode != null && !"".equals(m_sorgCode)) {
			sql.append(" AND O.MAIN_SORG_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(m_sorgCode);
		}
		if (sorgCode != null && !"".equals(sorgCode)) {
			sql.append(" AND O.SORG_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sorgCode);
		}
		if (sorgStatus != null && !"".equals(sorgStatus)) {
			sql.append(" AND O.SORG_STATUS= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sorgStatus);
		}
		if (cnName != null && !"".equals(cnName)) {
			sql.append(" AND O.CN_NAME like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(cnName);
		}
		if (morgName != null && !"".equals(morgName)) {// 区划
			String[] morgNameArr = morgName.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < morgNameArr.length; i++) {
				if (!"".equals(morgNameArr[i])) {
					if (!andFlag) {
						sql.append(" AND (");
					}
					andFlag = true;
					if (!orFlag) {
						sql.append(" INSTR(M.MORG_NAME,?,1)!=0");
						typeList.add(Types.VARCHAR);
						argsList.add(morgNameArr[i]);
						orFlag = true;
					} else {
						sql.append(" or INSTR(M.MORG_NAME,?,1)!=0");
						typeList.add(Types.VARCHAR);
						argsList.add(morgNameArr[i]);
					}
				}
			}
			if (andFlag) {
				sql.append(")");
			}
		}else{
			sql.append(" AND M.MORG_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(BspUtil.getCorpOrgan().getOrganName());
		}
		sql.append(" ORDER BY O.MORG_AREA,M.CN_NAME,O.SORG_CODE");
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,start,limit,true);
		}else{
			ds = this.executeDataset(sql.toString(),start,limit,true);
		}
		return ds;
	}
}
