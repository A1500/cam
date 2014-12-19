package com.inspur.cams.bpt.bptrecuperate.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail;
import com.inspur.cams.bpt.bptrecuperate.domain.IBptRecuperateDomain;
import com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleDao;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptRecuperateCommand
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
 */
public class BptRecuperateCommand extends BaseAjaxCommand {
	private IBptRecuperateDomain service = ScaComponentFactory.getService(
			IBptRecuperateDomain.class,
			"BptRecuperateDomain/BptRecuperateDomain");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptRecuperate dataBean = (BptRecuperate) record
				.toBean(BptRecuperate.class);
		dataBean.setRegOrganCode(BspUtil.getOrganCode());
		service.addBptRecuperateBatch(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptRecuperate dataBean = (BptRecuperate) record
				.toBean(BptRecuperate.class);
		dataBean.setRegOrganCode(BspUtil.getOrganCode());
		service.modifyBptRecuperateBacth(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		service.removeBptRecuperateBatch(delIds);
	}
	@Trans
	public void addDetails() {
		Record[] records = (Record[]) getParameter("baseinfos");
		String batchId = (String) getParameter("beachId");
		List<BptRecuperateDetail> details = new ArrayList<BptRecuperateDetail>();
		List<BptRecuperateDetail> updateDetails = new ArrayList<BptRecuperateDetail>();
		BptRecuperateDetail detail = null;
		String peopleId = "";
		String objectType = (String) getParameter("objectType");
		System.out.println(objectType);
		DataSet ds = null;
		for (Record record : records) {
			peopleId = (String) record.get("PEOPLE_ID");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", peopleId);
			pset.setParameter("BATCH_ID", batchId);
			ds = service.query(pset);
			if (ds.getCount() > 0) {
				detail = (BptRecuperateDetail) ds.getRecord(0).toBean(
						BptRecuperateDetail.class);
				updateDetails.add(detail);
			} else {
				detail = new BptRecuperateDetail();
				detail.setPeopleId(peopleId);
				detail.setBatchId(batchId);
				detail.setId(IdHelp.getUUID32());
				details.add(detail);
			}
			detail.setName((String) record.get("NAME"));
			// String disabilityNo = (String) record.get("disabilityNo");//伤残
			// String redaNo = (String) record.get("redaNo");//三红
			// String dependantNo = (String) record.get("dependantNo");//三属
			// String demobilizedNo = (String) record.get("demobilizedNo");//在乡
			// String warNo = (String) record.get("warNo");//参战参试
			// detail.setCredentialsNo((String) record.get(""));
			// System.out.println(disabilityNo+":1:"+redaNo+":2:"+demobilizedNo+":3:"+warNo+":");
			detail.setIdCard((String) record.get("ID_CARD"));
			detail.setBirthday((String)record.get("birthday"));
			if(objectType==null||objectType.equals("")){
				detail.setObjectType((String) record.get("OBJECT_TYPE"));
			}else{
				detail.setObjectType(objectType);
			}
		}
		service.addBptRecuperateDetail(batchId, details,updateDetails);
	}
	@Trans
	public void deleteDetails() {
		String[] delIds = (String[]) getParameter("delIds");
		String batchId = (String) getParameter("batchId");
		service.deleteDetails(batchId, delIds);
	}
	@Trans
	public void updateDetailPlace() {
		Record[] records = (Record[]) getParameter("records");
		List<BptRecuperateDetail> details = new ArrayList<BptRecuperateDetail>();
		if(records!=null){
			for (Record record : records) {
				BptRecuperateDetail detail = (BptRecuperateDetail) record.toBean(BptRecuperateDetail.class);
				details.add(detail);
			}
			service.updateDetailPlace(details);
		}
	}
	
	/**
	 * 通过peopleId查询familyId
	 */
	public void queryPeopleIdByFamilyId(){
		ParameterSet pset = getParameterSet();
		BaseinfoPeopleDao dao =  (BaseinfoPeopleDao) DaoFactory.getDao(BaseinfoPeopleDao.class);
		DataSet ds = dao.query(pset);
		String familyId = (String)ds.getRecord(0).get("familyId");
		setReturn("familyId", familyId);
	}
}
