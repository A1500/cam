package com.inspur.cams.marry.base.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.data.SamApplyFiles;
import com.inspur.cams.marry.base.dao.jdbc.MrmRegisOrganInfoDao;
import com.inspur.cams.marry.base.data.MrmRegisArea;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;
import com.inspur.cams.marry.base.data.MrmResourcesInfo;
import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;

/**
 * @title:MrmRegisOrganInfoCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
public class MrmRegisOrganInfoCommand extends BaseAjaxCommand{
	private MrmRegisOrganInfoDao dao = (MrmRegisOrganInfoDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmRegisOrganInfoDao");
	
	private IMrmRegisOrganInfoDomain mrmRegisOrganInfoDomain = (IMrmRegisOrganInfoDomain) ScaComponentFactory.getService(IMrmRegisOrganInfoDomain.class, "MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
	public void getDept() {//判断是否重复添加机关单位
		ParameterSet ps = new ParameterSet();
		Record record = (Record) getParameter("record");
		ps.setParameter("DEPT_CODE@=",record.get("deptCode"));
		IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
				IMrmRegisOrganInfoDomain.class, "MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
				DataSet ds=domain.query(ps);
				if(ds.getCount()>0){
					setReturn("result",true);
				}else{
					setReturn("result",false);
				}
	}
	public void insertAll() {
		mrmRegisOrganInfoDomain.insertAllPerson();
	}
	
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmRegisOrganInfo dataBean=(MrmRegisOrganInfo)record.toBean(MrmRegisOrganInfo.class);
		//基础信息
		String organId="";
		if(dataBean.getOrganId()==null || "".equals(dataBean.getOrganId())){
		    organId = IdHelp.getUUID32();
			dataBean.setOrganId(organId);
			dataBean.setValidFlag(new BigDecimal("1"));
		}
		if(dataBean.getRegionCode()!=null && !"".equals(dataBean.getRegionCode())){
			//MrmGetOrganIdInfo organIdDao=new MrmGetOrganIdInfo();
			dataBean.setPubOrganId(dao.checkOrganId(dataBean.getRegionCode().trim()));
		}
		// 面积
		
		Record[] areaRecords = (Record[]) getParameter("areaRecords");
		List<MrmRegisArea>  areaList= new ArrayList<MrmRegisArea>();
		if(areaRecords!=null && !"".equals(areaRecords) && areaRecords.length>0){
			for (int i = 0; i < areaRecords.length; i++) {
				// convert record to entity bean
				MrmRegisArea mrmRegisArea = (MrmRegisArea) areaRecords[i].toBean(MrmRegisArea.class);
				mrmRegisArea.setDeptId(dataBean.getDeptCode());
				mrmRegisArea.setFunctionId(IdHelp.getUUID32());
				areaList.add(mrmRegisArea);
			}
		}
		
	   //   资源
		Record[] resourceRecords = (Record[]) getParameter("resourceRecords");
		List<MrmResourcesInfo>  resourceList= new ArrayList<MrmResourcesInfo>();
		if(resourceRecords!=null && !"".equals(resourceRecords) && resourceRecords.length>0){
			for (int i = 0; i < resourceRecords.length; i++) {
				// convert record to entity bean
				MrmResourcesInfo mrmResourcesInfo = (MrmResourcesInfo) resourceRecords[i].toBean(MrmResourcesInfo.class);
				mrmResourcesInfo.setDeptId(dataBean.getDeptCode());
				mrmResourcesInfo.setResourceId(IdHelp.getUUID32());
				resourceList.add(mrmResourcesInfo);
			}
		}

		dataBean =  mrmRegisOrganInfoDomain.insert(dataBean,areaList,resourceList);
		setReturn("organId", dataBean.getOrganId());
		
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		MrmRegisOrganInfo dataBean=(MrmRegisOrganInfo)record.toBean(MrmRegisOrganInfo.class);
		if("".equals(dataBean.getValidFlag()) || dataBean.getValidFlag()==null){
			dataBean.setValidFlag(new BigDecimal("1"));
		}
// 面积
		
		Record[] areaRecords = (Record[]) getParameter("areaRecords");
		List<MrmRegisArea>  areaList= new ArrayList<MrmRegisArea>();
		if(areaRecords!=null && !"".equals(areaRecords) && areaRecords.length>0){
			for (int i = 0; i < areaRecords.length; i++) {
				// convert record to entity bean
				MrmRegisArea mrmRegisArea = (MrmRegisArea) areaRecords[i].toBean(MrmRegisArea.class);
				mrmRegisArea.setDeptId(dataBean.getDeptCode());
				mrmRegisArea.setFunctionId(IdHelp.getUUID32());
				areaList.add(mrmRegisArea);
			}
		}
		
	   //   资源
		Record[] resourceRecords = (Record[]) getParameter("resourceRecords");
		List<MrmResourcesInfo>  resourceList= new ArrayList<MrmResourcesInfo>();
		if(resourceRecords!=null && !"".equals(resourceRecords) && resourceRecords.length>0){
			for (int i = 0; i < resourceRecords.length; i++) {
				// convert record to entity bean
				MrmResourcesInfo mrmResourcesInfo = (MrmResourcesInfo) resourceRecords[i].toBean(MrmResourcesInfo.class);
				mrmResourcesInfo.setDeptId(dataBean.getDeptCode());
				mrmResourcesInfo.setResourceId(IdHelp.getUUID32());
				resourceList.add(mrmResourcesInfo);
			}
		}

		dataBean =  mrmRegisOrganInfoDomain.update(dataBean,areaList,resourceList);
		setReturn("organId", dataBean.getOrganId());
		
		dao.update(dataBean);
		setReturn("organId", dataBean.getOrganId());
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void deleteOrgan() {
		String organId = (String) getParameter("organId");
//		MrmRegisOrganInfo mrmRegisOrganInfo =new MrmRegisOrganInfo();
//		mrmRegisOrganInfo.setOrganId(new BigDecimal(organId));
		dao.delete(organId);
	}
	
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmRegisOrganInfo> list = new ArrayList<MrmRegisOrganInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmRegisOrganInfo dataBean = (MrmRegisOrganInfo) records[i].toBean(MrmRegisOrganInfo.class);
			if(dataBean.getOrganId()==null){
				String organId = IdHelp.getUUID32();
				dataBean.setOrganId(organId);
				dataBean.setValidFlag(new BigDecimal("1"));
				
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
	public void saveUpload() {
		Record uploadRd = (Record) getParameter("uploadRd");
		MrmRegisOrganInfo mrmRegisOrganInfo = (MrmRegisOrganInfo) uploadRd.toBean(MrmRegisOrganInfo.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			String fileName = uploadfile.getFileName();
			mrmRegisOrganInfo.setFileName(fileName);
			mrmRegisOrganInfo.setRegulation(uploadfile);
			
			//String applyFileId = samApplyFiles.getApplyFileId();
			//if (applyFileId == null || "".equals(applyFileId)) {
			//	samApplyFiles.setApplyFileId(IdHelp.getUUID30());
			//	samApplyFilesDomain.insert(samApplyFiles);
			//}
			mrmRegisOrganInfoDomain.updateWithFile(mrmRegisOrganInfo);
		}
	}
	@Trans
	public void updateValid() {
		Record record = (Record) getParameter("record");
		MrmRegisOrganInfo dataBean=(MrmRegisOrganInfo)record.toBean(MrmRegisOrganInfo.class);
		dataBean.setOrganId((String)record.get("ORGAN_ID"));
		dataBean.setValidFlag(new BigDecimal(record.get("VALID_FLAG").toString()));
		dao.updateValid(dataBean);
	}
}
