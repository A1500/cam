package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.ep.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;

/**
 * @title:FisCemeAccessoriesDao
 * @description:
 * @author:
 * @since:2011-11-30
 * @version:1.0
*/
 public class FisCemeAccessoriesDao extends EntityDao<FisCemeAccessories> implements IFisCemeAccessoriesDao{

 	public FisCemeAccessoriesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisCemeAccessories.class;
	}
   public void deleteStruAll() {
		executeUpdate("DELETE FROM FISCEMEACCESSORIES");
	}
   
   	public DataSet queryAccessories(ParameterSet pset){
   		String applayId = (String) pset.getParameter("applayId");
   		DataSet ds = new DataSet();
   		ds = executeDataset(" SELECT T.CODE  FROM DIC_CEME_ACCESSORIES_TYPE T ", false);
        List<Record> list = ds.getRecordSet();
        List<Record> returnList = new ArrayList<Record>();
        
        for(Record record:list){
        	FisCemeAccessories accessories = new FisCemeAccessories();
        	String code = (String) record.get("CODE");
        	accessories.setCode(code);
        	if(applayId !=null){
        		setAccessoriesName(accessories,code,applayId);
        	}
        	Record accessoriesRecord = new Record(accessories);
        	returnList.add(accessoriesRecord);
        }
        DataSet returnDs = new DataSet();
        returnDs.getRecordSet().addAll(returnList);
        return returnDs;
   	}

   	/**
   	 * 组装附件信息
   	 * @param accessories
   	 * @param code
   	 * @param applayId
   	 */
	private void setAccessoriesName(FisCemeAccessories accessories,
			String code, String applayId) {
		StringBuffer fileNameBuf = new StringBuffer();
		StringBuffer fileNoteBuf = new StringBuffer();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CODE@=", code);
		pset.setParameter("ITEM_ID@=", applayId);
		DataSet ds = query(pset);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				fileNameBuf.append(ds.getRecord(i).get("accessoriesName"));
				fileNameBuf.append(";");
				if(ds.getRecord(i).get("note")!=null){
					fileNoteBuf.append(ds.getRecord(i).get("note"));
					fileNoteBuf.append(";");
				}else{
					fileNoteBuf.append("  ");
					fileNoteBuf.append(";");
				}
			}
			accessories.setAccessoriesName(fileNameBuf.toString());
			accessories.setNote(fileNoteBuf.toString());
		}
	}

	public DataSet queryAccessoriesItem(ParameterSet pset) {
		DataSet ds = query(pset);
		return ds;
	}
   
}
