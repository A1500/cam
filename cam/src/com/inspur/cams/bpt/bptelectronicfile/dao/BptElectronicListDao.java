package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

/**
 * @title:BptElectronicListDao
 * @description:
 * @author:
 * @since:2011-07-15
 * @version:1.0
*/
public class BptElectronicListDao extends EntityDao<BptElectronicList> implements IBptElectronicListDao{

 	public BptElectronicListDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptElectronicList> getEntityClass() {
		return BptElectronicList.class;
	}
  	
  	/**
  	 * @ 根据档案目录号ID获得档案编号
  	 * @param contentNumId
  	 * @return
  	 */
	public String getArchiveNoByContentNumId(String contentNumId){
		String archiveNo = "";
		String sql = "SELECT MAX(Archive_No) ARCHIVENO FROM  BPT_ELECTRONIC_LIST WHERE content_num_id = ? ";
		DataSet ds = executeDataset(sql, new int[]{Types.VARCHAR},new Object[]{contentNumId},true);
		if(ds.getRecord(0).get("ARCHIVENO")!=null){
			archiveNo = (String)ds.getRecord(0).get("ARCHIVENO");
			int leth = archiveNo.length();
			String archiveNoPre = archiveNo.substring(0,leth-6);
			archiveNo = String.valueOf(Integer.valueOf(archiveNo.substring(leth-6))+1);
			leth = archiveNo.length();
			while(leth<6){
				StringBuffer temp = new StringBuffer();
				temp.append("0").append(archiveNo);
				archiveNo = temp.toString();
				leth = archiveNo.length();
			} 
	 		archiveNo = archiveNoPre + archiveNo;
		}else{
			String sql1 = "SELECT CONTENT_NUM_NAME FROM BPT_ELECTRONIC_CONTENT_NUM WHERE CONTENT_NUM_ID = ? ";
			archiveNo = (String)executeDataset(sql1, new int[]{Types.VARCHAR},new Object[]{contentNumId},true).getRecord(0).get("CONTENT_NUM_NAME")+"000001";
		}
		return archiveNo;
	}

}
