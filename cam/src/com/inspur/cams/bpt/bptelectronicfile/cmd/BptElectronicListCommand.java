package com.inspur.cams.bpt.bptelectronicfile.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicList;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicListDao;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptElectronicListCommand
 * @description:
 * @author:
 * @since:2011-07-15
 * @version:1.0
*/
public class BptElectronicListCommand extends BaseAjaxCommand{
	private BptElectronicListDao dao = (BptElectronicListDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicListDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptElectronicList dataBean=(BptElectronicList)record.toBean(BptElectronicList.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptElectronicList dataBean=(BptElectronicList)record.toBean(BptElectronicList.class);
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
		List<BptElectronicList> list = new ArrayList<BptElectronicList>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptElectronicList dataBean = (BptElectronicList) records[i].toBean(BptElectronicList.class);
			list.add(dataBean);
		}
		// do save
		BptElectronicListDao dao = (BptElectronicListDao) DaoFactory
				.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicListDao");
		dao.save(list);
	}
	@Trans
	public void savefile() {
		Record record = (Record) getParameter("bptElectronicRecord");
		String Id = IdHelp.getUUID30();
		String peopleId = (String) getParameter("peopleId");
		String organCode = (String) getParameter("organCode");
		String serviceType = (String) getParameter("serviceType");
		String contentNumId = (String) getParameter("contentNumId");
		String archiveNo = "";
		ParameterSet pset = new ParameterSet();
		pset.setParameter("DOMICILE_CODE", organCode);
		pset.setParameter("SERVICE_TYPE", serviceType);
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = dao.query(pset);
		if(ds.getCount()<1){
			BptElectronicList dataBean=(BptElectronicList)record.toBean(BptElectronicList.class);
			dataBean.setId(Id);
			dataBean.setPeopleId(peopleId);
			dataBean.setContentNumId(contentNumId);
			dataBean.setServiceType(serviceType);
			dataBean.setDomicileCode(organCode);
			dataBean.setRegId(BspUtil.getEmpOrganId());
			dataBean.setRegTime(DateUtil.getTime());
			archiveNo = dao.getArchiveNoByContentNumId(contentNumId);
			dataBean.setArchiveNo(archiveNo);
			dao.insert(dataBean);
		}else{
			Record electronicrecordList = ds.getRecord(0);
			BptElectronicList bptElectronicbean = (BptElectronicList) electronicrecordList.toBean(BptElectronicList.class);
			if(!bptElectronicbean.getContentNumId().equals(contentNumId)){
				bptElectronicbean.setContentNumId(contentNumId);
				archiveNo = dao.getArchiveNoByContentNumId(contentNumId);
				bptElectronicbean.setArchiveNo(archiveNo);
			}
			dao.update(bptElectronicbean);
		}
		setReturn("archiveNo", archiveNo);
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
}
