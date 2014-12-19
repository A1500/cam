package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptHouseSubsidyInfoDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptHouseSubsidyInfoCommand
 * @description:
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
public class BptHouseSubsidyInfoCommand extends BaseAjaxCommand{
	IBptHouseSubsidyInfoDomain service = ScaComponentFactory.getService(IBptHouseSubsidyInfoDomain.class,
	"bptHouseSubsidyInfoDomain/bptHouseSubsidyInfoDomain");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptHouseSubsidyInfo dataBean=(BptHouseSubsidyInfo)record.toBean(BptHouseSubsidyInfo.class);
		service.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptHouseSubsidyInfo dataBean=(BptHouseSubsidyInfo)record.toBean(BptHouseSubsidyInfo.class);
		service.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
	
	@Trans
	public void save() {
		
		IBptBaseinfoPeopleDomain peopleService = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		Record baseinfofamilyRecord = (Record) getParameter("BaseinfoFamilyRecord");
		BaseinfoFamily bean = (BaseinfoFamily) baseinfofamilyRecord.toBean(BaseinfoFamily.class);
		peopleService.updateBaseinfoFamily(bean);
		
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		if(records != null){
			List<BptHouseSubsidyInfo> list = new ArrayList<BptHouseSubsidyInfo>();
			for (int i = 0; i < records.length; i++) {
				// convert record to entity bean
				BptHouseSubsidyInfo dataBean = (BptHouseSubsidyInfo) records[i].toBean(BptHouseSubsidyInfo.class);
				if(dataBean.isNew()){
					dataBean.setHouseSubsidyId(IdHelp.getUUID30());
					dataBean.setFamilyId(baseinfofamilyRecord.get("familyId").toString());
				}
				list.add(dataBean);
			}
			service.save(list);
		}
	}
}
