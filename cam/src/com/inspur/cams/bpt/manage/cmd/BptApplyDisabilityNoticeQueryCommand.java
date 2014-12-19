package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptApplyDisabilityNoticeQueryCommand
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
public class BptApplyDisabilityNoticeQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");

	/**
	 * 获得受理通知书服务接口
	 */
	private IDisabilityNoticeDomain disabilityNoticeService = ScaComponentFactory.getService(IDisabilityNoticeDomain.class,
	"disabilityNoticeDomain/disabilityNoticeDomain");	
	
	@Trans
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet noticeDataSet = disabilityNoticeService.query(pset);
		if(noticeDataSet.getCount()>0){//如存在记录，则取其记录
			return noticeDataSet;
		}else{//如不存在，则插入一条记录
			String peopleId = getParameter("PEOPLE_ID").toString();
			String applyId = (String)getParameter("APPLY_ID");
			String serviceType = (String)getParameter("SERVICE_TYPE");
			pset.clear();
			pset.setParameter("PEOPLE_ID",peopleId);
			String name = service.queryPeople(pset).getRecord(0).get("name").toString();
			BptApplyDisabilityNotice dataBean = new BptApplyDisabilityNotice();
			dataBean.setPeopleId(peopleId);
			dataBean.setApplyId(applyId);
			dataBean.setName(name);
			dataBean.setServiceType(serviceType);
			disabilityNoticeService.insert(dataBean);
			return disabilityNoticeService.query(pset);
		}
	}
}
