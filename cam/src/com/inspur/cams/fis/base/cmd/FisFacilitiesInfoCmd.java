package com.inspur.cams.fis.base.cmd;

import java.util.*;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisFacilitiesInfo;
import com.inspur.cams.fis.base.domain.IFisFacilitiesInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisFacilitiesInfoCmd  
 * @Description: TODO 殡葬业务设施表Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisFacilitiesInfoCmd extends BaseAjaxCommand{
	
	IFisFacilitiesInfoDomain service = ScaComponentFactory.getService(IFisFacilitiesInfoDomain.class,
	"FisFacilitiesInfoDomain/FisFacilitiesInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisFacilitiesInfo dataBean=(FisFacilitiesInfo)record.toBean(FisFacilitiesInfo.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisFacilitiesInfo dataBean=(FisFacilitiesInfo)record.toBean(FisFacilitiesInfo.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.delete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisFacilitiesInfo> list = new ArrayList<FisFacilitiesInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisFacilitiesInfo dataBean = (FisFacilitiesInfo) records[i].toBean(FisFacilitiesInfo.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}
