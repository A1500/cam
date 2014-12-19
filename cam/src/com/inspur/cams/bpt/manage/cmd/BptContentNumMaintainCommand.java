package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptContentNumMaintainDao;
import com.inspur.cams.bpt.base.data.BptContentNumMaintain;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicList;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptContentNumMaintainCommand
 * @description:目录号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
public class BptContentNumMaintainCommand extends BaseAjaxCommand{
	private BptContentNumMaintainDao dao = (BptContentNumMaintainDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptContentNumMaintainDao");
	
	/**
	 * 通过行政区划和目录号名称查询目录号相关信息
	 */
	public void getContentInfo(){
		ParameterSet pset = getParameterSet();
		DataSet contentDataSet = dao.query(pset);
		Record contentRecord = contentDataSet.getRecord(0);
		if(contentRecord.get("contentNumId") != null){
			setReturn("contentNumId",contentRecord.get("contentNumId").toString());
		}
		
		if(contentRecord.get("contentNumName") != null){
			setReturn("contentNumName",contentRecord.get("contentNumName").toString());
		}
		
		if(contentRecord.get("fileCabinetName") != null){
			setReturn("fileCabinetName",contentRecord.get("fileCabinetName").toString());
		}
		
		if(contentRecord.get("layerNum") != null){
			setReturn("layerNum",contentRecord.get("layerNum").toString());
		}
		
		if(contentRecord.get("boxNum") != null){
			setReturn("boxNum",contentRecord.get("boxNum").toString());
		}
		
		if(contentRecord.get("contentYear") != null){
			setReturn("contentYear",contentRecord.get("contentYear").toString());
		}
		
		if(contentRecord.get("plaitDate") != null){
			setReturn("plaitDate",contentRecord.get("plaitDate").toString());
		}
	}
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptContentNumMaintain dataBean=(BptContentNumMaintain)record.toBean(BptContentNumMaintain.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptContentNumMaintain dataBean=(BptContentNumMaintain)record.toBean(BptContentNumMaintain.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void  checkDelete(){
		EntityDao<BptElectronicList> Electronicdao = (EntityDao<BptElectronicList>) DaoFactory.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicListDao");
		String[] delIds=(String[]) getParameter("delIds");
		ParameterSet pset = getParameterSet();
		StringBuffer cnids= new StringBuffer();
		for(String id: delIds){
			pset.clear();
			pset.setParameter("CONTENT_NUM_ID", id);
			int num = Electronicdao.query(pset).getCount();
			if(num>0){
				DataSet contentDataSet = dao.query(pset);
				Record contentRecord = contentDataSet.getRecord(0);
				cnids.append(contentRecord.get("contentNumName"));
				cnids.append(";");
			}else {
				dao.delete(id);
			}
			
		}
		setReturn("eid",cnids.toString());
	}
	@Trans
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		String organCode = (String)getParameter("organCode");
		String organName = (String)getParameter("organName");
		String archivalFondsId = (String)getParameter("archivalFondsId");
		
		List<BptContentNumMaintain> list = new ArrayList<BptContentNumMaintain>();
		for (int i = 0; i < records.length; i++) {
			BptContentNumMaintain dataBean = (BptContentNumMaintain) records[i].toBean(BptContentNumMaintain.class);
			if(dataBean.isNew()){
				dataBean.setContentNumId(IdHelp.getUUID30());
				dataBean.setArchivalFondsId(archivalFondsId);
				dataBean.setDomicileCode(organCode);
				dataBean.setDomicileName(organName);
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
			}else{
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
}
