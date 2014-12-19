package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.util.HashMap;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

/**
 * @title:BptElectronicFileDao
 * @description:
 * @author:
 * @since:2011-06-27
 * @version:1.0
 */
public class BptElectronicFileDao extends EntityDao<BptElectronicFile>
		implements IBptElectronicFileDao {
	private static String deleteSql = "delete from bpt_electronic_file t where t.electronic_id=? and t.file_id=? ";
	private static String querySql = "select to_char(nvl(count(electronic_id)+1,1)) filenum from bpt_electronic_file t where t.electronic_id=? ";

	public BptElectronicFileDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<BptElectronicFile> getEntityClass() {
		return BptElectronicFile.class;
	}
	/**
	 * 根据电子文档id获得当前id下文件数量+1
	 */
	public int getFileNum(String electronicId) {
		int[] arg1 = { java.sql.Types.CHAR };
		String[] arg2 = { electronicId };
		List list =  this.executeQuery(querySql, arg1, arg2);
		for (int i = 0; i < list.size(); i++) {
			HashMap m=(HashMap) list.get(i);
			return Integer.parseInt((String)m.get("FILENUM"));
		}
		return 1;

	}
	/**
	 * 根据电子文档id和文件id删除
	 */
	public int deleteByeid_fid(String electronicId, String fileId) {
		int[] arg1 = { java.sql.Types.CHAR, java.sql.Types.CHAR };
		String[] arg2 = { electronicId, fileId };
		return this.executeUpdate(deleteSql, arg1, arg2);
	}

}
