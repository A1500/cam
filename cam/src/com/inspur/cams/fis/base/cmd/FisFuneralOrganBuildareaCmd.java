package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganBuildareaDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisFuneralOrganBuildareaCmd
 * @Description: TODO 殡葬业务殡仪馆信息表Cmd
 * @author xuexzh
 * @date 2012-7-12
 */
public class FisFuneralOrganBuildareaCmd extends BaseAjaxCommand {
	IFisFuneralOrganBuildareaDomain service = ScaComponentFactory
			.getService(IFisFuneralOrganBuildareaDomain.class, "FisFuneralOrganBuildareaDomain/FisFuneralOrganBuildareaDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisFuneralOrganBuildarea dataBean = (FisFuneralOrganBuildarea) record.toBean(FisFuneralOrganBuildarea.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisFuneralOrganBuildarea dataBean = (FisFuneralOrganBuildarea) record.toBean(FisFuneralOrganBuildarea.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		service.delete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisFuneralOrganBuildarea> list = new ArrayList<FisFuneralOrganBuildarea>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisFuneralOrganBuildarea dataBean = (FisFuneralOrganBuildarea) records[i].toBean(FisFuneralOrganBuildarea.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}
