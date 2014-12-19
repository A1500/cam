package com.inspur.cams.comm.menuconfig.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.loushang.bsp.organization.data.Stru;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.object.MappingSqlQuery;

public class MenuConfigSearchDao extends EntityDao<Stru> implements IMenuConfigSearchDao{
	private final static String underlingQuerySql = getUnderlingQuerySql();
	
	public DataSet getQueryUnderling(StruView struView, ParameterSet param) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		GetUnderlingQuery queryer = new GetUnderlingQuery(getDataSource());
		String organTypeIdq = (String) param.getParameter("organTypeIdq");
		String organNameq = (String) param.getParameter("organNameq");
		String organCodeq = (String) param.getParameter("organCodeq");
		StringBuffer sb = new StringBuffer(queryer.getSql());
		sb.append(" WHERE O.ORGAN_ID=S.ORGAN_ID AND O.ORGAN_CODE = M.ORGAN_CODE(+) ");
		sb.append("AND O.ORGAN_TYPE=OT.ORGAN_TYPE AND ST.STRU_TYPE=S.STRU_TYPE ");
		//对于员工类型的，更改查询条件
		if(struView.getOrganType().equals("8")){
			sb.append("AND S.STRU_ID = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(struView.getStruId());
		}else{
			sb.append("AND S.STRU_PATH LIKE ?");
			typeList.add( Types.VARCHAR );
			objsList.add(struView.getStruPath()+"#%");
		}
		sb.append("AND S.IN_USE='1' ");
		if (organTypeIdq != null && !organTypeIdq.equals("")) {
			sb.append("AND O.ORGAN_TYPE = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(organTypeIdq);
		}
		if (organCodeq != null && !organCodeq.equals("")) {
			sb.append("AND O.ORGAN_CODE LIKE '%");
			typeList.add( Types.VARCHAR );
			objsList.add(organCodeq+"%");
		}
		if (organNameq != null && !organNameq.equals("")) {
			sb.append("AND O.ORGAN_NAME LIKE ?%");
			typeList.add( Types.VARCHAR );
			objsList.add("%"+organNameq+"%");
		}
		sb.append(" ORDER BY S.STRU_PATH ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sb.toString(), types, args, param
					.getPageStart(), param.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sb.toString(), param.getPageStart(), param
					.getPageLimit(), true);
		}
		return ds;
	}
	
	protected static class GetUnderlingQuery extends MappingSqlQuery {
		protected GetUnderlingQuery(DataSource ds) {
			super(ds, underlingQuerySql);
		}
		protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			return getStruView(rs, false);
		}
	}
	
	protected static StruView getStruView(ResultSet rs, boolean isHist) {
		StruView struView = new StruView();
		try {
			struView.setStruId(rs.getString("STRU_ID"));
			struView.setOrganId(rs.getString("ORGAN_ID"));
			struView.setParentId(rs.getString("PARENT_ID"));
			struView.setStruType(rs.getString("STRU_TYPE"));
			struView.setStruLevel(rs.getInt("STRU_LEVEL"));
			struView.setStruPath(rs.getString("STRU_PATH"));
			struView.setStruOrder(rs.getInt("STRU_ORDER"));
			struView.setIsLeaf(rs.getString("IS_LEAF"));
			struView.setInUseStru(rs.getString("IN_USE"));
			struView.setOrganName(rs.getString("ORGAN_NAME"));
			struView.setOrganType(rs.getString("ORGAN_TYPE"));
			struView.setOrganCode(rs.getString("ORGAN_CODE"));
			struView.setShortName(rs.getString("SHORT_NAME"));
			struView.setOrganTypeName(rs.getString("ORGAN_TYPE_NAME"));
			struView.setStruTypeName(rs.getString("STRU_TYPE_NAME"));
			struView.setInUseOrgan(rs.getString("IN_USE_ORGAN"));
		} catch (Exception e) {
			throw new RuntimeException("组织结构数据转换出现错误，操作无法继续" + e);
		}
		return struView;
	}
	
	public static String getUnderlingQuerySql() {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT S.STRU_ID,S.ORGAN_ID,S.STRU_TYPE,S.PARENT_ID,S.STRU_LEVEL,S.STRU_PATH,S.STRU_ORDER,S.IS_LEAF,S.IN_USE,");
		sb.append("O.ORGAN_CODE AS ORGAN_CODE,O.ORGAN_NAME AS ORGAN_NAME,O.SHORT_NAME AS SHORT_NAME,O.ORGAN_TYPE,O.IN_USE AS IN_USE_ORGAN,");
		sb.append("OT.TYPE_NAME AS ORGAN_TYPE_NAME,ST.TYPE_NAME AS STRU_TYPE_NAME,M.MENU_TYPE_NAME AS MENU_TYPE_NAME ");
		sb.append("FROM PUB_STRU S,PUB_ORGAN O,PUB_ORGAN_TYPE OT,PUB_STRU_TYPE ST,PUB_MENU_CONFIG M");
		return sb.toString();
	}

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return Stru.class;
	}
	
	public DataSet getMenuType(ParameterSet param){
		String sql = "SELECT MENU_TYPE_ID,MENU_TYPE_NAME FROM PUB_MENU_TYPE ";
		DataSet ds = executeDataset(sql, param.getPageStart(), param
				.getPageLimit(), true);
		return ds;
	}
	

}
