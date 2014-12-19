package com.inspur.cams.sorg.query.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.query.dao.ISomEntityStaticDao;

public class SomEntityStaticDao extends EntityDao<SomOrgan> implements ISomEntityStaticDao {
	@SuppressWarnings("unchecked")
	protected Class getEntityClass() {
		return SomOrgan.class;
	}

	/**
	 * 社团举办实体统计
	 */
	public DataSet groupEntityStatic(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		List<Object> argsList = new ArrayList<Object>();
		String cxsjq=(String)pset.getParameter("cxsjq");
		String cxsjz=(String)pset.getParameter("cxsjz");
		String xzqu=(String)pset.getParameter("xzqu");
		if(cxsjq==null||"".equals(cxsjq)){
			cxsjq="1900-01-01";
		}
		if(cxsjz==null||"".equals(cxsjz)){
			cxsjz="3000-01-01";
		}
		argsList.add(cxsjq);
		argsList.add(cxsjz);
		if(xzqu.indexOf("0000000000")!=-1){
			argsList.add(xzqu.subSequence(0, xzqu.indexOf("0000000000"))+"%"+"00000000");
		}else if(xzqu.indexOf("00000000")!=-1){
			argsList.add(xzqu.subSequence(0, xzqu.indexOf("00000000"))+"%"+"000000");
		}else if(xzqu.indexOf("000000")!=-1){
			argsList.add(xzqu.subSequence(0, xzqu.indexOf("000000"))+"%"+"000000");
		}
		argsList.add(cxsjq);
		argsList.add(cxsjz);
		sql.append("SELECT A.NAME, 																		\n");
		sql.append("	   A.ID, 																		\n");
		sql.append("	   NVL(A.COUNT, 0) COUNT, 														\n");
		sql.append("	   NVL(B.COUNT_BUILD, 0) COUNT_BUILD, 											\n");
		sql.append("	   NVL(ROUND(B.COUNT_BUILD * 100 / A.COUNT, 2), 0)||'%' RATE_BUILD, 			\n");
		sql.append("	   NVL(A.COUNT - B.COUNT_BUILD, 0) COUNT_UNBUILD,								\n");
		sql.append("	   NVL(ROUND((A.COUNT - B.COUNT_BUILD) * 100 / A.COUNT, 2), 0)||'%' RATE_UNBUILD, 		\n");
		sql.append("	   NVL(B.COUNT_E , 0) COUNT_E 													\n");
		sql.append("  FROM (SELECT T.ID, T.NAME, A.COUNT												\n");
		sql.append("          FROM DIC_CITY T															\n");		
		sql.append("          LEFT JOIN (SELECT A.MORG_AREA , COUNT(1) COUNT							\n");
		sql.append("                      FROM SOM_ORGAN A												\n");
		sql.append(" 					 WHERE A.IF_BRANCH = '0'										\n");
		sql.append("   					   AND A.SORG_TYPE = 'S'										\n");
		sql.append("   					   AND A.REG_DATE >= ?											\n");
		sql.append("   					   AND A.REG_DATE <= ?											\n");
		sql.append("   					   AND A.SORG_STATUS IN ('22')								\n");
		sql.append(" 					 GROUP BY A.MORG_AREA ) A  										\n");
		sql.append("            ON T.ID = A.MORG_AREA													\n");
		sql.append("         WHERE T.ID LIKE ?) A														\n");
		sql.append("  LEFT JOIN (SELECT B.MORG_AREA, 													\n"); 
		sql.append("					COUNT(BB.COUNT) COUNT_BUILD,									\n");
		sql.append("					SUM(BB.COUNT) COUNT_E											\n");
		sql.append("               FROM SOM_ORGAN B														\n");
		sql.append("               JOIN (SELECT COUNT(1) COUNT, SORG_ID									\n");
		sql.append("                      FROM SOM_ENTITY												\n");
		sql.append("                     GROUP BY SORG_ID) BB											\n");
		sql.append("                 ON BB.SORG_ID = B.SORG_ID											\n");
		sql.append("              WHERE B.IF_BRANCH = '0'												\n");
		sql.append("                AND B.SORG_TYPE = 'S'												\n");
		sql.append("   				AND B.REG_DATE >= ?													\n");
		sql.append("   				AND B.REG_DATE <= ?													\n");
		sql.append("   				AND B.SORG_STATUS IN ('22')									\n");
		sql.append("              GROUP BY B.MORG_AREA) B												\n");
		sql.append("    ON A.ID = B.MORG_AREA															\n");
		sql.append(" ORDER BY A.ID																		\n");
		if (typeList.size() > 0 && argsList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		}
		return ds;
	}
}
