package com.inspur.cams.fis.base.dao.jdbc;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.fis.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.base.data.FisCemeAccessories;

/**
 * 公墓审批附件表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeAccessoriesDao extends EntityDao<FisCemeAccessories> implements IFisCemeAccessoriesDao {
	
	@Override
	public Class<FisCemeAccessories> getEntityClass() {
		return FisCemeAccessories.class;
	}
	
	public DataSet queryAccessories(ParameterSet pset){
   		String applayId = (String) pset.getParameter("applayId");
   		String acode = (String) pset.getParameter("code");
   		DataSet ds = new DataSet();
   		ds = executeDataset(" SELECT T.CODE  FROM DIC_CEME_ACCESSORIES_TYPE T WHERE T.CODE LIKE '%"+acode+"%'", false);
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
	
	public DataSet queryAccessoryType(ParameterSet pset){
   		String applayId = (String) pset.getParameter("applayId");
   		String startCode = (String) pset.getParameter("startCode");
   		String endCode = (String) pset.getParameter("endCode");
   		DataSet ds = new DataSet();
   		ds = executeDataset(" SELECT T.CODE  FROM DIC_CEME_ACCESSORIES_TYPE T WHERE T.CODE BETWEEN '"+startCode+"' AND '"+endCode+"' ORDER BY T.CODE DESC", false);
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
	
	public void deleteAll(ParameterSet pset) {
		String itemId = (String) pset.getParameter("itemId");
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_ACCESSORIES WHERE ITEM_ID = '"+itemId+"'");
		executeUpdate(sql.toString());
	}
}