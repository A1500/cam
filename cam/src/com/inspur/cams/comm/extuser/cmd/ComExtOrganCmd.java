package com.inspur.cams.comm.extuser.cmd;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
//import com.inspur.aims.organ.base.data.AimOrganBranch;
//import com.inspur.aims.organ.base.domain.IAimOrganBranchDomain;
import com.inspur.cams.comm.extuser.data.ComExtOrgan;
import com.inspur.cams.comm.extuser.domain.IComExtOrganDomain;
import com.inspur.cams.drel.mbalance.data.SamMServiceArea;
import com.inspur.cams.drel.mbalance.domain.ISamMServiceAreaDomain;
//import com.inspur.comm.util.IdHelp;

/**
 * 外部单位cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganCmd extends BaseAjaxCommand {

	// 外部单位domain
	private IComExtOrganDomain comExtOrganDomain = (IComExtOrganDomain) ScaComponentFactory.getService(IComExtOrganDomain.class, "comExtOrganDomain/comExtOrganDomain");
	
	private ISamMServiceAreaDomain samMServiceAreaDomain=ScaComponentFactory.getService(ISamMServiceAreaDomain.class, "samMServiceAreaDomain/samMServiceAreaDomain");

	//获取分支机构 domain
	//private IAimOrganBranchDomain aimOrganBranchDomain = ScaComponentFactory.getService(IAimOrganBranchDomain.class, "aimOrganBranchDomain/aimOrganBranchDomain");

	/**
	 * 增加外部单位
	 */
	@Trans
	public void insert() {
		Record record = (Record) getParameter("comExtOrgan");
		String areaCode = (String) getParameter("areaCodes");
		String saveStatus = (String) getParameter("saveStatus");
		ComExtOrgan comExtOrgan = (ComExtOrgan) record.toBean(ComExtOrgan.class);
		comExtOrgan.setSaveStatus(saveStatus);
		ComExtOrgan organ = comExtOrganDomain.insertComExtOrgan(comExtOrgan);
		if(StringUtils.isNotEmpty(areaCode)){
			String[] areaCodes=areaCode.split(","); 
			for(int i=0;i<areaCodes.length;i++){
				SamMServiceArea dataBean=new SamMServiceArea();
				dataBean.setOrganId(organ.getOrganId());
				dataBean.setAreaCode(areaCodes[i]);
				samMServiceAreaDomain.insert(dataBean);
			}
		}
		setReturn("organId", organ.getOrganId());
		setReturn("areaCodes", areaCode);
	}
	
	/**
	 * 修改外部单位
	 */
	@Trans
	public void update() {

		String areaCode = (String) getParameter("areaCodes");
		Record record = (Record) getParameter("comExtOrgan");
		String saveStatus = (String) getParameter("saveStatus");
		ComExtOrgan comExtOrgan = (ComExtOrgan) record.toBean(ComExtOrgan.class);
		comExtOrgan.setSaveStatus(saveStatus);
		comExtOrganDomain.updateComExtOrgan(comExtOrgan);
		String delIds[]=new String[1];
		delIds[0]=comExtOrgan.getOrganId();
		samMServiceAreaDomain.delete(delIds);
		if(StringUtils.isNotEmpty(areaCode)){
			String[] areaCodes=areaCode.split(","); 
			for(int i=0;i<areaCodes.length;i++){
				SamMServiceArea dataBean=new SamMServiceArea();
				dataBean.setOrganId(comExtOrgan.getOrganId());
				dataBean.setAreaCode(areaCodes[i]);
				samMServiceAreaDomain.insert(dataBean);
			}
		}
	}

	/**
	 * 逻辑删除外部单位
	 */
	@Trans
	public void delete() {
		String organId = (String) getParameter("organId");
		comExtOrganDomain.deleteComExtOrgan(organId);
	}
	/**
	 * 增加外部单位
	 
	@Trans
	public void branchInsert() {
		Record record = (Record) getParameter("comExtOrgan");
		String areaCode = (String) getParameter("areaCodes");
		String saveStatus = (String) getParameter("saveStatus");
		ComExtOrgan comExtOrgan = (ComExtOrgan) record.toBean(ComExtOrgan.class);
		comExtOrgan.setSaveStatus(saveStatus);
		ComExtOrgan organ = comExtOrganDomain.insertComExtOrgan(comExtOrgan);
		if(StringUtils.isNotEmpty(areaCode)){
			String[] areaCodes=areaCode.split(","); 
			for(int i=0;i<areaCodes.length;i++){
				SamMServiceArea dataBean=new SamMServiceArea();
				dataBean.setOrganId(organ.getOrganId());
				dataBean.setAreaCode(areaCodes[i]);
				samMServiceAreaDomain.insert(dataBean);
			}
		}
		setReturn("organId", organ.getOrganId());
		setReturn("areaCodes", areaCode);
		if (!"".equals(getParameter("records"))&& getParameter("records") != null) {
			Record[] records = (Record[]) getParameter("records");
			if(records.length!=0){
				branchSave(organ.getOrganId());
			}
		}
	}
	*/
	/**
	 * 修改外部单位
	
	@Trans
	public void branchUpdate() {

		String areaCode = (String) getParameter("areaCodes");
		Record record = (Record) getParameter("comExtOrgan");
		String saveStatus = (String) getParameter("saveStatus");
		ComExtOrgan comExtOrgan = (ComExtOrgan) record.toBean(ComExtOrgan.class);
		comExtOrgan.setSaveStatus(saveStatus);
		comExtOrganDomain.updateComExtOrgan(comExtOrgan);
		String delIds[]=new String[1];
		delIds[0]=comExtOrgan.getOrganId();
		samMServiceAreaDomain.delete(delIds);
		if(StringUtils.isNotEmpty(areaCode)){
			String[] areaCodes=areaCode.split(","); 
			for(int i=0;i<areaCodes.length;i++){
				SamMServiceArea dataBean=new SamMServiceArea();
				dataBean.setOrganId(comExtOrgan.getOrganId());
				dataBean.setAreaCode(areaCodes[i]);
				samMServiceAreaDomain.insert(dataBean);
			}
		}
		if (!"".equals(getParameter("records"))&& getParameter("records") != null) {
			Record[] records = (Record[]) getParameter("records");
			if(records.length!=0){
				branchSave(comExtOrgan.getOrganId());
			}
		}
	}
	 */
	/** 
	 * 保存、修改、删除、增加 分支机构
	@Trans
	public void branchSave(String organId) {
		Record[] records = (Record[]) getParameter("records");
		String createPeople = (String) getParameter("createPeople");
		List<AimOrganBranch> list = new ArrayList<AimOrganBranch>();
		if (records.length > 0) {
			for (int i = 0; i < records.length; i++) {
				Record rd = records[i];
				String baseId = IdHelp.getUUID32();
				AimOrganBranch aimOrganBranch = (AimOrganBranch) rd
						.toBean(AimOrganBranch.class);
				aimOrganBranch.setBaseId(baseId);
				aimOrganBranch.setOrganId(organId);
				int state = aimOrganBranch.getState();
				if (state == 1) {
					aimOrganBranch.setCreatePeople(createPeople);
					String getTime = "";
					Date dt = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm:ss");
					getTime = sdf.format(dt);

					aimOrganBranch.setCreateTime(getTime);
					aimOrganBranch.setCreatePeopleId(organId);
				}
				list.add(aimOrganBranch);
			}
			aimOrganBranchDomain.save(list);
		}
	}
	*/
}

