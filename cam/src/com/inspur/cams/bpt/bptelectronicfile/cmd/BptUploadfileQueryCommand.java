package com.inspur.cams.bpt.bptelectronicfile.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfile;


/**
 * @title:BptUploadfileQueryCommand
 * @description:
 * @author:
 * @since:2011-06-21
 * @version:1.0
*/
public class BptUploadfileQueryCommand extends BaseQueryCommand{
	
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptUploadfile> dao = (EntityDao<BptUploadfile>) DaoFactory.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfileDao");
		return dao.query(pset);
	}
	
	/**
	 * 通过业务类型查询档案目录
	 */
	public DataSet queryContentByServiceType(){
		// 电子档案目录dao
		BptCatalogueArchivesDao bptCatalogueArchivesDao = (BptCatalogueArchivesDao)DaoFactory.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
		
		String serviceType = (String)getParameter("serviceType");
		String organCode = (String)getParameter("organCode");
		
		DataSet returnDataSet = new DataSet();
		
		ParameterSet pset = new ParameterSet();
		pset.clear();
		pset.setParameter("SERVICE_TYPE",serviceType);
		pset.setParameter("UP_CATALOG_CODE@<>","0");
		pset.setParameter("ORGAN_ID",organCode);
		pset.setSortField("SERVICE_TYPE,CATALOG_ORDER");
		
		//如果本行政区划不存在目录，取省里的目录
		if(bptCatalogueArchivesDao.query(pset).getCount()<1){     //本行政区划不存在目录
			pset.remove("ORGAN_ID");
			pset.setParameter("ORGAN_ID", "370000000000");
		}
		pset.remove("SERVICE_TYPE");
		if(serviceType.equals("11")){   //伤残
			pset.setParameter("SERVICE_TYPE@in","11,12,13,14,15,16,17,18,19");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("21")){ //三属
			pset.setParameter("SERVICE_TYPE@in","21,22,23,24,25");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("41")){  //在乡复员军人
			pset.setParameter("SERVICE_TYPE@in","41,42,43,44,4A");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("45")){ //带病回乡退伍军人
			pset.setParameter("SERVICE_TYPE@in","45,46,47,48,4B");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("51")){  //参战
			pset.setParameter("SERVICE_TYPE@in","51,52,53,54,55");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("61")){  //参试
			pset.setParameter("SERVICE_TYPE@in","61,62,63,64,65");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }else if("81".equals(serviceType)){  //退役老兵
			pset.setParameter("SERVICE_TYPE@in","81,82,83,84");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }else if("B1".equals(serviceType)){  //老烈士子女
			pset.setParameter("SERVICE_TYPE@in","B1,B2,B3,B4");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }
		return returnDataSet;
	}	
	
	/**
	 * 通过业务类型查询档案目录
	 *//*
	public DataSet queryBaseinforContentByServiceType(){
		// 电子档案目录dao
		BptCatalogueArchivesDao bptCatalogueArchivesDao = (BptCatalogueArchivesDao)DaoFactory.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
		
		String serviceType = (String)getParameter("serviceType");
		String organCode = (String)getParameter("organCode");
		
		DataSet returnDataSet = new DataSet();
		
		ParameterSet pset = new ParameterSet();
		pset.clear();
		pset.setParameter("SERVICE_TYPE",serviceType);
		pset.setParameter("UP_CATALOG_CODE@<>","0");
		pset.setParameter("ORGAN_ID",organCode);
		pset.setSortField("SERVICE_TYPE,CATALOG_ORDER");
		
		//如果本行政区划不存在目录，取省里的目录
		if(bptCatalogueArchivesDao.query(pset).getCount()<1){     //本行政区划不存在目录
			pset.remove("ORGAN_ID");
			pset.setParameter("ORGAN_ID", "370000000000");
		}
		pset.remove("SERVICE_TYPE");
		if(serviceType.equals("11")){   //伤残
			pset.setParameter("SERVICE_TYPE@in","11,12,13,14,15,16,17,18,19,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("21")){ //三属
			pset.setParameter("SERVICE_TYPE@in","21,22,23,24,25,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("41")){  //在乡复员军人
			pset.setParameter("SERVICE_TYPE@in","41,42,43,44,4A,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("45")){ //带病回乡退伍军人
			pset.setParameter("SERVICE_TYPE@in","45,46,47,48,4B,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("51")){  //参战
			pset.setParameter("SERVICE_TYPE@in","51,52,53,54,55,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
		}else if(serviceType.equals("61")){  //参试
			pset.setParameter("SERVICE_TYPE@in","61,62,63,64,65,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }else if("81".equals(serviceType)){  //退役老兵
			pset.setParameter("SERVICE_TYPE@in","81,82,83,84,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }else if("B1".equals(serviceType)){  //老烈士子女
			pset.setParameter("SERVICE_TYPE@in","B1,B2,B3,B4,99");
			returnDataSet = bptCatalogueArchivesDao.query(pset);
	    }
		return returnDataSet;
	}*/
	
	
	/**
	 * 工作流等：通过业务类型查询档案目录
	 */
	public DataSet queryContentByServiceTypeOther(){
		// 电子档案目录dao
		BptCatalogueArchivesDao bptCatalogueArchivesDao = (BptCatalogueArchivesDao)DaoFactory.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
		
		//String peopleId = (String)getParameter("peopleId");
		String serviceType = (String)getParameter("serviceType");
		String organCode = (String)getParameter("organCode");		
		DataSet returnDataSet = new DataSet();		
		//ParameterSet pset = new ParameterSet();
		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("SERVICE_TYPE@=",serviceType);
		pset.setParameter("UP_CATALOG_CODE@<>","0");
		pset.setParameter("ORGAN_ID",organCode);
		pset.setSortField("catalogOrder");
		
		//如果本行政区划不存在目录，取省里的目录
		if(bptCatalogueArchivesDao.query(pset).getCount()<1){     //本行政区划不存在目录
			pset.remove("ORGAN_ID");
			pset.setParameter("ORGAN_ID", "370000000000");			
		}
		returnDataSet = bptCatalogueArchivesDao.query(pset);				
		return returnDataSet;
	}
}
