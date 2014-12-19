package com.inspur.cams.marry.base.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.dao.jdbc.MrmLevelEvalutionInfoDao;
import com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo;

/**
 * @title:MrmLevelEvalutionInfoCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class MrmLevelEvalutionInfoCommand extends BaseAjaxCommand{
	private MrmLevelEvalutionInfoDao dao = (MrmLevelEvalutionInfoDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmLevelEvalutionInfoDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmLevelEvalutionInfo dataBean=(MrmLevelEvalutionInfo)record.toBean(MrmLevelEvalutionInfo.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		MrmLevelEvalutionInfo dataBean=(MrmLevelEvalutionInfo)record.toBean(MrmLevelEvalutionInfo.class);
		dao.update(dataBean);
	}

//	public void delete() {
//		String[] delIds=(String[]) getParameter("delIds");
//		dao.batchDelete(delIds);
//	}
	@Trans
	public void delete() {
		Integer[] delIds=(Integer[]) getParameter("delIds");
		for(int i=0;i<delIds.length;i++){
			dao.delete(delIds[i]+"");
		}
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmLevelEvalutionInfo> list = new ArrayList<MrmLevelEvalutionInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmLevelEvalutionInfo dataBean = (MrmLevelEvalutionInfo) records[i].toBean(MrmLevelEvalutionInfo.class);
			if(dataBean.getEvaluId()==null){
				int evaluId = MaxValueUtil.nextIntValue("DJPD_ID");
				dataBean.setEvaluId(BigDecimal.valueOf(evaluId));
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
}