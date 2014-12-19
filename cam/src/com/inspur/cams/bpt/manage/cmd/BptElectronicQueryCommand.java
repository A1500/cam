package com.inspur.cams.bpt.manage.cmd;



import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao;
import com.inspur.cams.bpt.base.data.BptElectronic;
import com.inspur.cams.bpt.base.domain.IBptElectronicDomain;
import com.inspur.cams.bpt.edoc.dao.IBptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.data.BptCatalogueArchives;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptElectronicQueryCommand
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
public class BptElectronicQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	/**
	 * 电子档案服务接口
	 */
	IBptElectronicDomain bptElecttronicService = ScaComponentFactory.getService(IBptElectronicDomain.class,
	"BptElectronicDomain/BptElectronicDomain");

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptElectronic> dao = (EntityDao<BptElectronic>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao");
		return dao.query(pset);
	}
	
	/**
	 * 优抚对象信息管理修改人员信息，选择档案目录，加入公共目录部分
	 */
	public DataSet queryBaseInforSelectedContents(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("PEOPLE_ID");
		if(peopleId!=null&&!"".equals(peopleId)){
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("PEOPLE_ID",peopleId);
			String domicileCode = (String)service.queryPeople(pset1).getRecord(0).get("domicileCode");
			domicileCode = domicileCode.substring(0,6) + "000000";
			pset1.clear();
			pset1.setParameter("ORGAN_ID", domicileCode);
			IBptCatalogueArchivesDao dao = (BptCatalogueArchivesDao) DaoFactory
			.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
			pset.remove("ORGAN_ID");
			if(dao.query(pset1).getCount()<1){     //本行政区划不存在目录
				pset.setParameter("ORGAN_ID", "370000000000");
			}else{
				pset.setParameter("ORGAN_ID",domicileCode);
			}
		}
		return bptElecttronicService.queryBaseInforSelectedContents(pset);
	}
	
	/**
	 * 查询已经选择的档案目录
	 */
	public DataSet querySelectedContent(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("PEOPLE_ID");
		if(peopleId!=null&&!"".equals(peopleId)){
			ParameterSet pset1 = new ParameterSet();
			pset1.setParameter("PEOPLE_ID",peopleId);
			String domicileCode = (String)service.queryPeople(pset1).getRecord(0).get("domicileCode");
			domicileCode = domicileCode.substring(0,6) + "000000";
			pset1.clear();
			pset1.setParameter("ORGAN_ID", domicileCode);
			EntityDao<BptCatalogueArchives> dao = (EntityDao<BptCatalogueArchives>) DaoFactory
			.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
			pset.remove("ORGAN_ID");
			if(dao.query(pset1).getCount()<1){     //本行政区划不存在目录
				pset.setParameter("ORGAN_ID", "370000000000");
			}else{
				pset.setParameter("ORGAN_ID",domicileCode);
			}
		}
		return bptElecttronicService.querySelectedContents(pset);
	}
	
	/**
	 * 获取档案信息
	 * @return
	 */
	public DataSet queryProElectronic(){
		ParameterSet pSet = getParameterSet();
		DataSet dataSet = null;
		try {
			BptElectronicDao bptElectronicDao = new BptElectronicDao();
		
			dataSet = bptElectronicDao.queryProcessElectronic(pSet);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dataSet;
	}
	/**
	 * 获取档案盒中的人员信息
	 * @return
	 */
	public DataSet queryContentPeople(){
		ParameterSet pset = getParameterSet();
		DataSet ds =bptElecttronicService.queryContentPeople(pset);
		return ds;
	}
	/**
	 * 获取档案详细信息
	 * @return
	 */
	public DataSet queryProElectronicInfo() {
		ParameterSet pSet = getParameterSet();
		DataSet dataSet = null;
		try {
			BptElectronicDao bptElectronicDao = new BptElectronicDao();
		
			dataSet = bptElectronicDao.queryProcessElectronicInfo(pSet);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dataSet;
	}
	/**
	 * 获取档案详细信息打印
	 * @return
	 */
	public DataSet queryProcessElectronicPrint() {
		ParameterSet pSet = getParameterSet();
		DataSet dataSet = null;
		dataSet = bptElecttronicService.queryProcessElectronicPrint(pSet);
		
		return dataSet;
	}
	public DataSet queryElectronicPrintCover(){
		
		ParameterSet pSet = getParameterSet();
		DataSet dataSet = bptElecttronicService.queryElectronicPrintCover(pSet);
		return dataSet;
	}
}
