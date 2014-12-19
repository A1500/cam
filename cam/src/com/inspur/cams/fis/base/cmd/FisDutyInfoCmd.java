package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisDutyInfo;
import com.inspur.cams.fis.base.domain.IFisDutyInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisDutyInfoCmd  
 * @Description: TODO 殡葬业务人员岗位信息表Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisDutyInfoCmd extends BaseAjaxCommand{
	IFisDutyInfoDomain service = ScaComponentFactory.getService(IFisDutyInfoDomain.class,
	"FisDutyInfoDomain/FisDutyInfoDomain");
	public void insert() {
		Record record = (Record) getParameter("record");
		FisDutyInfo dataBean=(FisDutyInfo)record.toBean(FisDutyInfo.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisDutyInfo dataBean=(FisDutyInfo)record.toBean(FisDutyInfo.class);
		service.update(dataBean);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisDutyInfo> list = new ArrayList<FisDutyInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisDutyInfo dataBean = (FisDutyInfo) records[i].toBean(FisDutyInfo.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}
