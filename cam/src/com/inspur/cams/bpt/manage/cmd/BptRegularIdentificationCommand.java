package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptRegularIdentification;
import com.inspur.cams.bpt.base.domain.IBptRegularIdentificationDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptRegularIdentificationCommand
 * @description:定期认证维护
 * @author:
 * @since:2011-05-27
 * @version:1.0
*/
public class BptRegularIdentificationCommand extends BaseAjaxCommand{
	private IBptRegularIdentificationDomain service = ScaComponentFactory.getService(IBptRegularIdentificationDomain.class,
			"bptRegularIdentificationDomain/bptRegularIdentificationDomain");

	/**
	 * 添加更新定期认证维护
	 */
/*	public void insert() {
		Record[] record = (Record[]) getParameter("record");
		for (Record r : record) {
			BptRegularIdentification dataBean=(BptRegularIdentification)r.toBean(BptRegularIdentification.class);
			System.out.println(dataBean.getIdentificationId());
			if(dataBean.getIdentificationId()==null||"".equals(dataBean.getIdentificationId())){
				dataBean.setIdentificationId(IdHelp.getUUID30());
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
				dataBean.setModId(BspUtil.getEmpOrganId());
				dataBean.setModTime(DateUtil.getTime());
				dataBean.setIdentiFlag("1");
				service.insert(dataBean);
			}else {
				service.updateRegIdenti(dataBean);
			}
		}
	}
*/
	/**
	 * 新增和修改定期认证信息
	 */
	@Trans
	public void save(){
		Record[] records = (Record[])getParameter("records");
		int len = records.length;
		if(len>0){
			for(int i=0;i<len;i++){
				BptRegularIdentification dataBean = (BptRegularIdentification)records[i].toBean(BptRegularIdentification.class);
				String identificationId = dataBean.getIdentificationId();
				if("".equals(identificationId)||identificationId==null){
					dataBean.setIdentificationId(IdHelp.getUUID32());
					dataBean.setRegId(BspUtil.getEmpOrganId());
					dataBean.setRegTime(DateUtil.getTime());
					dataBean.setIdentiFlag("1");
					dataBean.setModId(BspUtil.getEmpOrganId());
					dataBean.setModTime(DateUtil.getTime());
					service.insert(dataBean);
				}else{
					dataBean.setModId(BspUtil.getEmpOrganId());
					dataBean.setModTime(DateUtil.getTime());
					service.updateRegIdenti(dataBean);
				}
			}
		}
	}
	
	/**
	 * 查询是否定期认证
	 * PeopleId
	 */
	public void whetherIdentification(){
		ParameterSet pSet = getParameterSet();
		String peopleId = (String) pSet.getParameter("peopleId");
		pSet.setParameter("PEOPLEID", peopleId);
//		pSet.remove("peopleId");
		DataSet dataSet = service.queryRI(pSet);
		Record record = dataSet.getRecord(0);
		String identiFlag = (String) record.get("IDENTI_FLAG");
		this.setReturn("identiFlag", identiFlag);
	}
	
	/**
	 * 批量添加定期认证
	 */
	@Trans
	public void batchIdenti(){
		ParameterSet pset = getParameterSet();
		String[] peopleId = (String[])pset.getParameter("peopleId");
		for(int i=0;i<peopleId.length;i++){
			String peopleID = peopleId[i];
			BptRegularIdentification dataBean = new BptRegularIdentification();
			dataBean.setIdentificationId(IdHelp.getUUID30());
			dataBean.setPeopleId(peopleID);
			dataBean.setIdentificationDate(DateUtil.getDay());
			dataBean.setIdentificationResult("已认证");
			dataBean.setIdentiFlag("1");
			dataBean.setRegId(BspUtil.getEmpOrganId());
			dataBean.setRegTime(DateUtil.getTime());
			dataBean.setModId(BspUtil.getEmpOrganId());
			dataBean.setModTime(DateUtil.getTime());
			service.insert(dataBean);
		}
	}
	/*public void update() {
		Record[] record = (Record[]) getParameter("record");
		for (Record r : record) {
			BptRegularIdentification  dataBean=(BptRegularIdentification)r.toBean(BptRegularIdentification.class);
			service.updateRegIdenti(dataBean);
		}
	}*/
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.deleteRegIdenti(delIds);
	}
}
