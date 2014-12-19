package com.inspur.cams.bpt.edoc.dao.jdbc;

import java.sql.*;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.bpt.edoc.dao.IBptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.data.BptCatalogueArchives;


/**
 * @title:BptCatalogueArchivesDao
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
 public class BptCatalogueArchivesDao extends EntityDao<BptCatalogueArchives> implements IBptCatalogueArchivesDao{

 	public BptCatalogueArchivesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptCatalogueArchives> getEntityClass() {
		return BptCatalogueArchives.class;
	}
  	
    public void deleteStruAll() {
		executeUpdate("delete from BptCatalogueArchives");
	}

	public DataSet queryOrgan(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT P.ORGAN_CODE, P.ORGAN_NAME\n");
		sql.append("  FROM PUB_ORGAN P, BPT_CATALOGUE_ARCHIVES T\n"); 
		sql.append(" WHERE P.ORGAN_CODE = T.ORGAN_ID AND P.IN_USE = '1'");
		String domicileCode = (String) pset.getParameter("domicileCode");
		String organCode = BspUtil.getOrganCode();
		String arg = "";
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" AND ORGAN_CODE= ? ");// 省局
				arg = domicileCode ;
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
				sql.append(" AND SUBSTR(ORGAN_CODE,1,4)= ? ");//市局
				arg = domicileCode.substring(0, 4);
			}else{
				sql.append(" AND (SUBSTR(ORGAN_CODE,1,6)=? OR ORGAN_CODE = '370000000000')");//区县
				arg = domicileCode.substring(0, 6);
			}
			sql.append(" AND P.ORGAN_TYPE='13'");
		}else{
			if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 4).equals("00")) {
				sql.append(" AND ORGAN_CODE= ? ");// 省局
				arg = organCode;
			}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 6).equals("00")){
				sql.append(" AND SUBSTR(ORGAN_CODE,1,4)= ? ");//市局
				arg = organCode.substring(0, 4) ;
			}else{
				sql.append(" AND (SUBSTR(ORGAN_CODE,1,6)= ? OR ORGAN_CODE = '370000000000')");//区县
				arg = organCode.substring(0, 6) ;
			}
		}
		sql.append(" AND (T.ORGAN_ID= ? OR T.ORGAN_ID = '370000000000') and p.organ_id  like 'O0000000%'");
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{arg,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
    
	public DataSet getFlag(ParameterSet pset){
		String catalogCode = (String) pset.getParameter("catalogCode");
		String organId =(String) pset.getParameter("organCode");
		String sql ="SELECT CATALOG_ID FROM BPT_CATALOGUE_ARCHIVES WHERE ORGAN_ID=? AND CATALOG_CODE=?";
		return this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{organId,catalogCode}, true);
	}
}
