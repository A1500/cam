package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao;
import com.inspur.cams.bpt.base.data.BptElectronic;
import com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand;
import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptElectronicCommand
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
public class BptElectronicCommand extends BaseAjaxCommand{
	private BptElectronicDao dao = (BptElectronicDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptElectronic dataBean=(BptElectronic)record.toBean(BptElectronic.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptElectronic dataBean=(BptElectronic)record.toBean(BptElectronic.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptElectronic> list = new ArrayList<BptElectronic>();

		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			String electronicId =records[i].get("electronicId").toString();
			BptUploadfileCommand bptUploadfileCommand = new BptUploadfileCommand();

			BptElectronic dataBean = (BptElectronic) bptUploadfileCommand.ElectronicId(electronicId).getRecord(0).toBean(BptElectronic.class);
			dataBean.setFileType(records[i].get("catalogCode").toString());
			dataBean.setFileOper(records[i].get("fileOper").toString());
			dataBean.setFileTime(records[i].get("fileTime").toString());
			dataBean.setFileNumber(records[i].get("fileNumber").toString());
			list.add(dataBean);
		}

		dao.batchUpdate(list);
	}
	/**
	 * 根据peopleId查询记录
	 *
	 * @return
	 */
	public DataSet peopleIdByid(String peopleId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet ds = dao.query(pset);
		return ds;
	}
	//获取单个档案
	public List<HashMap> getElectronic(String electronicId){
		ParameterSet pset = new ParameterSet();
		List<HashMap> list=new ArrayList<HashMap>();
		pset.setParameter("electronicId", electronicId);
		DataSet ds = dao.getElectronic(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			HashMap<String,String> m=new HashMap<String,String>();
			m.put("fileId",(String)ds.getRecord(i).get("FILE_ID"));
			m.put("fileName",(String)ds.getRecord(i).get("FILE_NAME"));
			m.put("rangeFlag",(String)ds.getRecord(i).get("RANGE_FLAG"));
			list.add(m);
		}
		return list;
		
		
	}
	//获取个人所有档案
	public List<HashMap> getElectronicAll(String Id,String serviceType,String peopleId){
		ParameterSet pset = new ParameterSet();
		List<HashMap> list=new ArrayList<HashMap>();
		String electronicId ="";
		String stype="";
		String[] stypeArray ={};
		String[] IdArray = Id.split(":");
		if(serviceType.contains(":")){//人员基本信息中时发送多个serviceType
			stypeArray = serviceType.split(":");
		}
		
		pset.setParameter("PEOPLE_ID",peopleId);
		IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
		String domicileCode = (String)service.queryPeople(pset).getRecord(0).get("domicileCode");
		String organCode = domicileCode.substring(0,6)+"000000";
		String organFlag = null;
		pset.clear();
		//判断本行政区划是否存在目录
		BptCatalogueArchivesDao adao = (BptCatalogueArchivesDao) DaoFactory
				.getDao(BptCatalogueArchivesDao.class);
		pset.setParameter("ORGAN_ID", organCode);
		DataSet ds = adao.query(pset);
		if(ds.getCount()>1){
			organFlag = "1";
		}else{
			organFlag = "0";
		}
		for (int j=0;j<IdArray.length;j++) {
			electronicId = IdArray[j];
			if(stypeArray.length!=0){
				stype=stypeArray[j];
			}else{
				stype=serviceType;
			}
			pset.clear();
			pset.setParameter("electronicId", electronicId);
			pset.setParameter("stype", stype);
			pset.setParameter("organFlag", organFlag);
			pset.setParameter("organCode", organCode);
			DataSet eds = dao.getElectronicAll(pset);
			for (int i = 0; i < eds.getCount(); i++) {
				HashMap<String,String> m=new HashMap<String,String>();
				m.put("fileId",(String)eds.getRecord(i).get("FILE_ID"));
				m.put("fileName",(String)eds.getRecord(i).get("FILE_NAME"));
				m.put("rangeFlag",(String)eds.getRecord(i).get("RANGE_FLAG"));
				list.add(m);
			}
		}
		return list;
	}
}
